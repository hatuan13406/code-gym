# calculator-app

Standalone Maven consumer of the independent binary JAR `lib/math-lib.jar`.

Build: `mvn clean package`

Run (Windows): `java -cp "target/classes;lib/math-lib.jar" com.codegym.Main`

Run (macOS/Linux): `java -cp "target/classes:lib/math-lib.jar" com.codegym.Main`

The source tree intentionally does not include `Calculator.java`.
