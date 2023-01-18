# Note. I already ran on cluster. Please don't run again
set ff=unix
for yr in `seq 2020 2022`; do
  for mnth in `seq -w 1 12`; do
    wget --no-check-certificate https://divvy-tripdata.s3.amazonaws.com/${yr}${mnth}-divvy-tripdata.zip;
  done
done
