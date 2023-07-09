import gulp from "gulp";
import sonarqubeScanner from "sonarqube-scanner";

gulp.task("sonar", function (callback) {
  sonarqubeScanner(
    {
      serverUrl: "http://localhost:9000",
      options: {},
    },
    callback
  );
});
