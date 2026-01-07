## Esse projeto é um pipeline CI/CD automatizado com GitHub Actions e Terraform para criação de um ambiente de infraestrutura na AWS.

O disparo do pipeline é manual via aba Actions do GitHub, onde temos a opção de aplicar o "run workflow"
Temos 3 opções de execução desse pipeline.

1 - "Executar o apply em prod" -> True or False - Com true, o terraform executa todo o processo e já aplica em produção. Com false, apenas faz o planejamento do que será construido.
2 - "Planejar o destrou do ambiente?" -> True or False - Com true, você faz o planejamento de tudo que será deletado em produção. Com false, apenas não faz nada.
3 - "Executar o destroy em produção?" -> True or False - Com true, você executa a deleção dos arquivos que foi previamente planejado (recomendado rs) na opção anterior. Com false, apenas não faz nada.

O que esse pipeline faz?

- Faz o checkout do nosso repositório no GitHub
- Configura as credenciais da AWS e assume uma role préviamente criada na AWS
- Instala o terraform e dá sequência aos comandos de Init, Format, Validate, Plan, Apply / Destroy do Terraform

O que o terraform faz?

- Cria um bucket S3 na AWS onde será armazenado nosso backend no arquivo 'backend.tf'
- Cria uma instância EC2 ('ec2.tf') e já executa o comando que está definido no 'user_data.sh' que é atualização do SO e instalação do Docker na instância
- Cria um Security Group ('ec2.tf') juntamente com suas regras de Ingress e Egress
- Cria um repositório no ECR ('ecr.tf')

Rodando esse pipeline, temos a nossa infraestrutura instalada na AWS, devidamente pronta para ser recebida a nossa aplicação, que neste caso é feito por outro pipeline através de algum commit, que disparará o deploy da imagem docker contendo o nosso site estático.

