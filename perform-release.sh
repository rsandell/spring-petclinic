#!/bin/bash
echo Pushing the bits!
echo ========================
find ./ -iname spring-*.jar -printf %f\\n
echo ========================
echo Release Done!
