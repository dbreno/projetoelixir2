
# Rick and Morty Wiki

Este é um projeto de uma Wiki do universo de Rick and Morty, desenvolvido como parte do projeto final da disciplina de Programação Funcional no curso de Ciência da Computação da Universidade Federal da Paraíba (UFPB). O objetivo é criar uma aplicação funcional utilizando Elixir e Phoenix, onde os usuários possam consultar informações detalhadas sobre personagens, episódios e locais do desenho animado Rick and Morty.

## Índice

- [Visão Geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Configuração do Projeto](#configuração-do-projeto)
- [Como Usar](#como-usar)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Contribuindo](#contribuindo)
- [Licença](#licença)
- [Contato](#contato)

## Visão Geral

A aplicação é uma plataforma para explorar o mundo de Rick and Morty. Ela oferece:

- Busca e filtragem de personagens com base em nome, status, espécie, gênero e origem.
- Busca e filtragem de episódios pelo nome, ID e código do episódio.
- Busca e filtragem de locais com base no nome, tipo e dimensão.

## Funcionalidades

- **Pesquisa de Personagens**: Busque por nome, status (vivo, morto, desconhecido), espécie, gênero e origem.
- **Pesquisa de Episódios**: Filtre episódios por nome, código ou ID para ver detalhes como data de lançamento.
- **Pesquisa de Locais**: Explore locais com filtros por nome, tipo (planeta, estação espacial, etc.) e dimensão.
- **Interface Responsiva**: O projeto inclui uma interface amigável, com um menu hambúrguer para dispositivos móveis e transições animadas.

## Configuração do Projeto

### Pré-requisitos

- **Elixir**: Certifique-se de ter Elixir e Mix instalados.
- **Phoenix Framework**: Instale o Phoenix Framework para rodar o servidor.
- **Node.js e npm**: Necessários para gerenciar dependências JavaScript, como TailwindCSS (caso esteja usando assets customizados).

### Passo a Passo

1. Clone este repositório:
   ```bash
   git clone https://github.com/dbreno/projetoelixir2.git
   cd projetoelixir2
   ```

2. Instale as dependências do projeto:
   ```bash
   mix deps.get
   ```

3. Instale as dependências de assets (caso necessário):
   ```bash
   cd assets
   npm install
   cd ..
   ```

4. Compile o projeto:
   ```bash
   mix compile
   ```

5. Inicie o servidor Phoenix:
   ```bash
   mix phx.server
   ```

6. Acesse a aplicação: Abra o navegador e acesse `http://localhost:4000` para ver a aplicação rodando localmente.

### Estrutura de Diretórios

- `/assets`: Contém os assets da aplicação, incluindo JavaScript e CSS.
- `/config`: Configurações da aplicação.
- `/lib`: Contém o código principal, incluindo controladores e módulos do Phoenix.
- `/priv`: Contém arquivos estáticos, templates e outros recursos privados.
- `/test`: Testes do projeto.

## Como Usar

1. Navegue para as seções de **Characters**, **Episodes**, ou **Locations** usando a barra de navegação.
2. Use os filtros em cada seção para encontrar informações específicas sobre personagens, episódios ou locais.
3. Clique no botão **Apply Filters** para aplicar os filtros escolhidos.

### Exemplo de Pesquisa

Para encontrar o personagem "Rick Sanchez", vá para a página **Characters** e insira "Rick Sanchez" no campo de nome. Clique em **Apply Filters** para ver os resultados.

## Tecnologias Utilizadas

- **Elixir e Phoenix Framework**: Backend funcional para criar APIs e renderizar HTML.
- **TailwindCSS**: Estilização e responsividade.
- **JavaScript**: Para funcionalidades do frontend, como o menu hambúrguer.
- **Rick and Morty API**: Fonte de dados para informações sobre personagens, episódios e locais.

## Contribuindo

Contribuições são bem-vindas! Siga os passos abaixo para contribuir:

1. Faça um fork deste repositório.
2. Crie um branch com a nova feature:
   ```bash
   git checkout -b feature/nova-feature
   ```
3. Commit suas alterações:
   ```bash
   git commit -m 'Adiciona nova feature'
   ```
4. Envie para o branch principal:
   ```bash
   git push origin feature/nova-feature
   ```
5. Abra um Pull Request para revisão.

## Licença

Este projeto é apenas para fins acadêmicos e de aprendizado. Não possui licença comercial.

## Contato

Caso tenha dúvidas ou sugestões, entre em contato com o grupo de desenvolvimento:

- Antonio Augusto Dantas Neto
- Davi de Lacerda Teixeira
- Deivily Breno Silva Carneiro

Este projeto foi desenvolvido para aprendizado em Elixir e Phoenix. Agradecemos por sua visita e esperamos que goste da aplicação!
