r=1

for den in 0.2 0.4 0.6 0.8; do
for temp in 0.7 0.8 1.0 1.2 1.4 1.6 1.8 2.0; do

cp -r input-template T-${temp}-D-${den}-$r
cd T-${temp}-D-${den}-$r
sed -i -e "s/TEMPERATURE/${temp}/g" -e "s/DENSITY/${den}/g" -e "s/RANDOM/$r/g" in.df
sbatch single.run
cd ..

done
done

