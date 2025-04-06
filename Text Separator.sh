#!/bin/bash
parca=$2
dosya=$1
sayac=1;


while [[ $sayac -gt 0 ]] #Dosya adını kontrol ediyoruz.
do
	if [ -f $dosya ] #Dosyanın varlığı kontrol ediliyor
	then 
		echo "Dosya bulundu."   # Varsa döngüden çık 
		break
	else 
		printf "Dosya bulunamadı! \nYeni bir dosya adı girin veya girilen dosya adının kontrol edin!\n "  # Yoksa dosya adını tekrar iste
		read dosya
	fi
done


kontrol=$(wc -l < $dosya) # satır sayılarını kontrol değişkenine atadık
while [[ $parca -gt $kontrol || $parca -le 0 ]]; do  #parcanın negatif veya satır sayısından büyük mü diye kontrol ediyoruz 
	echo "İstenilen parça sayısı, satır sayısından küçük olmalıdır!";
	echo "Yeni bir değer girin: ";
	read parca
done


printf "İşlem Yapılacak Dosya Adı: $dosya\n"
printf "$dosya içerisinde $kontrol adet satır bulundu.\n"
printf "$dosya $parca parçaya bölünüyor...\n"; 


#parça sayısı kadar döngüye aldık
for i in $(seq 1 $parca); do
  yeniDosya="Turkish-$i.dic" # dosya ismini belirledik 
  touch $yeniDosya #dosya oluşturduk
  ilk=$(((i-1)*kontrol/parca+1)) # satırları parçaladık 
  son=$((i*kontrol/parca))
  sed -n "$ilk,$son p" $dosya > $yeniDosya # parcalanan satırları dosyalara atadık
done

echo "İşlem tamamlandı!"



