library(caret)
library(caretEnsemble)
data(iris)

set.seed(123)

train_idx <- createDataPartition(iris$Species, p=0.6, list=FALSE)
train <- iris[train_idx, ]
test <- iris[-train_idx, ]

ctrl <- trainControl(method="repeatedcv",
                     number=10,
                     repeats=3,
                     savePredictions="final")

models <- caretList(
    Species ~ .,
    data=train,
    trControl=ctrl,
    methodList=c("rf", "knn", "gbm", "lda", "nnet"),
    continue_on_fail=TRUE
)

preds <- predict(models, test)

vote <- as.factor(apply(preds, 1, function(row) {
    names(which.max(table(row)))
}))

print(confusionMatrix(vote, test$Species))
saveRDS(models, "model.rds")
