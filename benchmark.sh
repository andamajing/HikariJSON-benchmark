#!/bin/bash

if [[ ! -e "./target/microbenchmarks.jar" ]]; then
   mvn clean package
fi

JAVA_OPTS="-server -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -Xmx512m -D_jmh.stack.period=20"

#JAVA_OPTS="$JAVA_OPTS -XX:+UnlockDiagnosticVMOptions -XX:+LogCompilation -XX:+TraceClassLoading -XX:+PrintAssembly -XX:PrintAssemblyOptions=intel -XX:-UseCompressedOops"

if [[ "quick" == "$1" ]]; then
   java -jar ./target/microbenchmarks.jar -jvmArgs "$JAVA_OPTS" -wi 3 -i 6 -t 1 -f 2 $2 $3 $4 $5 $6 $7 $8 $9
elif [[ "medium" == "$1" ]]; then
   java -jar ./target/microbenchmarks.jar -jvmArgs "$JAVA_OPTS" -w 3 -t 1 -f 3 $2 $3 $4 $5 $6 $7 $8 $9
elif [[ "flight" == "$1" ]]; then
   JAVA_OPTS="$JAVA_OPTS -XX:+UnlockCommercialFeatures -XX:+FlightRecorder"
   java -jar ./target/microbenchmarks.jar -jvmArgs "$JAVA_OPTS" -w 3 -t 1 -f 1 -i 500 $2 $3 $4 $5 $6 $7 $8 $9
elif [[ "profile" == "$1" ]]; then
   java -server -agentpath:/Applications/jprofiler8/bin/macos/libjprofilerti.jnilib=port=8849 -jar ./target/microbenchmarks.jar -r 5 -wi 8 -i 8 -t 1 -f 0 $2 $3 $4 $5 $6 $7 $8 $9
elif [[ "debug" == "$1" ]]; then
   java -server -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=y -jar ./target/microbenchmarks.jar -r 5 -wi 8 -i 8 -t 1 -f 0 $2 $3 $4 $5 $6 $7 $8 $9
else
   java -jar ./target/microbenchmarks.jar -jvmArgs "$JAVA_OPTS" -wi 3 -i 20 -t 1 $1 $2 $3 $4 $5 $6 $7 $8 $9
fi
