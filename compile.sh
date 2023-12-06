JOB="./jobs/$1.tex"
if ! test -f $JOB; then
  echo "Job file at $JOB does not exist!"
  exit 127
fi

if [[ $2 = ref* ]]; then
  REF="\def\references{}"
else
  echo "Won't include references!"
fi

lualatex "\def\myjob{$JOB}$REF\input{resume.tex}" > compile.log
rm -f resume.aux resume.log resume.out compile.log
echo -e "\nDone ^_^\nOutput at: resume.pdf"