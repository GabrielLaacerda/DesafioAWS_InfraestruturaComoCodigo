#!/bin/bash

usuarios=()

function adiciona_user() {
    usuarios+=("$1,$2,$3","$4")	
}

adiciona_user "carlos" "/bin/bash" "Senha123" 1
adiciona_user "maria" "/bin/bash" "Senha123" 1
adiciona_user "joao" "/bin/bash" "Senha123" 1
adiciona_user "debora" "/bin/bash" "Senha123" 2
adiciona_user "sebastiana" "/bin/bash" "Senha123" 2
adiciona_user "roberto" "/bin/bash" "Senha123" 2
adiciona_user "josefina" "/bin/bash" "Senha123" 3
adiciona_user "amanda" "/bin/bash" "Senha123" 3
adiciona_user "rogerio" "/bin/bash" "Senha123" 3

echo -e "==================Configuração Usuários/Diretórios=================="
echo -e "\nCriando Diretórios..."

mkdir /public 
mkdir /adm 
mkdir /ven 
mkdir /sec

echo -e "Concluído!!"

echo -e "\nCriando grupos de usuários..."

groupadd GRP_ADM 
groupadd GRP_VEN 
groupadd GRP_SEC

echo -e "Concluído!!"

echo -e "\nCriando Usuários...\n"

for (( i=0; i<${#usuarios[@]}; i++ ))
do
    nome=$(echo ${usuarios[i]} | cut -d',' -f1)
    shell=$(echo ${usuarios[i]} | cut -d',' -f2)
    senha=$(echo ${usuarios[i]} | cut -d',' -f3)
    gr=$(echo ${usuarios[i]} | cut -d',' -f4)
    
    if [ $gr -eq 1 ]
    then
      grupo="GRP_ADM"
    elif [ $gr -eq 2 ]
    then
      grupo="GRP_VEN"
    else
      grupo="GRP_SEC"
    fi

    useradd "$nome" -m -s "$shell" -p $(openssl passwd -crypt Senha123) -G "$grupo"

    echo -e "Usuário $nome criando com sucesso!!"
	
done

echo -e "Concluído!!"

echo -e "\nEspecificando permisses dos diretórios..."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven 
chmod 770 /sec
chmod 777 /public

echo -e "Concluído!!\n"

echo -e "\n***CONFIGURAÇÃO REALIZADA COM SUCESSO***\n"
