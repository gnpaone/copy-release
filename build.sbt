name := "copy-repo-release"
version := "1.1.0"
scalaVersion := "3.7.4"

libraryDependencies ++= Seq(
  "org.kohsuke" % "github-api" % "1.318",
  "org.slf4j" % "slf4j-simple" % "2.0.13"
)

assembly / mainClass := Some("Main")
