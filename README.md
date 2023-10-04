
![Logo](https://i.imgur.com/0gi2aWH.png)



## O problema e como podemos tentar resolvê-lo

Com a crescente divergência de código entre as branches na empresa em que trabalho, a possibilidade de fazer merges de grandes funcionalidades/correções a partir das mesclagens está se tornando cada vez mais complicada. Percebi que as pessoas estão usando o cherry-pick com frequência para compor as branches. Tendo em mente que todas as branches/commits possuem os cards explícitos em seus nomes/comentários, pensei em uma forma de automatizar esse processo para pegar os commits de um determinado card a partir de sua branch centralizadora e aplicá-los na branch desejada.

Para quem ficou boiando na forma em que formato as mensagens / nomes das branches podem ser organizados, deixo aqui um exemplo para melhor esclarecimento:

```
branches:
[Código do Card da feature/fix]-nome-da-branch-centralizadora

commits:
[Código do Card da feature/fix]: Texto do que foi feito no commit
```
## Como rodar o script em meu repositório?


- Clone o repositório
    ```bash
      git pull https://github.com/MarceloJDCB/jira-pick.git
    
      cd jira-pick
    ```

- Copie o jira_pick.bash, cole na pasta do projeto .git que desejar
  e o execute utilizando:
    ```bash
    bash jira_pick.bash

- Caso esteja utilizando
  um Makefile crie um comando personalizado para o script da seguinte
  forma:
  ```
  jira_pick:
      bash jira_pick.bash
    
