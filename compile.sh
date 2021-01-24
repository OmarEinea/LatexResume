JOB=$1
if [[ $2 = ref* ]]
then REF="\def\references{}"
else echo "Won't include references!"
fi
xelatex "\def\myjob{jobs/$JOB}$REF\input{resume.tex}" -job-name=$JOB -quiet
rm -f $JOB.aux $JOB.log $JOB.out $JOB.bcf $JOB.run.xml $JOB.synctex.gz