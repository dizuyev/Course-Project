x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
f<-read.table("./UCI HAR Dataset/features.txt")
train<-cbind(x_train, y_train, subject_train)
test<-cbind(x_test, y_test, subject_test)
xys<-rbind(train, test)
fs<-as.character(f$V2)
names(xys)[1:561]<-c(fs)
td1<-xys[, grep("(.*)mean\\(\\)(.*)", f$V2)]
td2<-xys[, grep("(.*)std\\(\\)(.*)", f$V2)]
td0<-xys[, 562:563]
td<-cbind(td0, td1, td2)
tda<-left_join(td, activity)
tdf<-select(tda, -V1)
names(tdf)[1]<-"subject"
names(tdf)[68]<-"activity"
itdf<-ddply(tdf, .(subject, activity), colwise(mean))
write.table(itdf, file="course_project.txt", row.names=FALSE)
