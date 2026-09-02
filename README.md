**Autor / Author:** Eduardo Mussulini

🚧 **Projeto em andamento** · 🚧 **Work in progress**

---

## 🇧🇷 Sobre o Projeto

Este é um projeto de estudo prático em **automação de testes com Playwright e TypeScript**, construído do zero como um monorepo com frontend estático (`apps/web`) e backend Node.js/Express com SQLite (`apps/api`) — o **Mark**, um gerenciador de tarefas usado como aplicação de demonstração para os testes.

Testes automatizados são uma parte vital do desenvolvimento de software moderno. Conforme uma aplicação evolui, os testes de regressão crescem a cada nova versão, e depender apenas de execução manual se torna caro e lento. Automatizar essas verificações reduz drasticamente essa carga de trabalho e aumenta a confiança em cada entrega.

O Playwright é uma ferramenta poderosa e flexível para testes automatizados de aplicações web, usada inclusive por grandes players do mercado (como o Disney+). Combinado com TypeScript, ele se torna ainda mais robusto para escrever testes de ponta a ponta (E2E) de forma tipada, escalável e sustentável.

O objetivo deste repositório é documentar minha jornada de estudo, aplicando na prática:

- Criação de um projeto Node.js do zero, com instalação e configuração completa do Playwright para testes E2E em TypeScript;
- Exploração dos recursos e conceitos fundamentais do framework, com boas práticas de automação aplicadas ao Mark;
- Geração de relatórios de testes de regressão com evidências em imagens e vídeos;
- Um pipeline de testes contínuos com Playwright rodando no GitHub Actions, controlando o fluxo de execução com relatórios, screenshots e métricas — sem depender de rodar tudo localmente.

## 🇺🇸 About the Project

This is a hands-on study project in **test automation with Playwright and TypeScript**, built from the ground up as a monorepo with a static frontend (`apps/web`) and a Node.js/Express backend with SQLite (`apps/api`) — **Mark**, a task manager used as the demo application for testing.

Automated testing is a vital part of modern software development. As an application evolves, regression tests grow with every new release, and relying solely on manual execution becomes expensive and slow. Automating these checks drastically reduces that workload and increases confidence in every release.

Playwright is a powerful and flexible tool for automated testing of web applications, used by major players in the industry (such as Disney+). Combined with TypeScript, it becomes even more robust for writing end-to-end (E2E) tests in a typed, scalable, and maintainable way.

The goal of this repository is to document my study journey, applying in practice:

- Building a Node.js project from scratch, with full installation and configuration of Playwright for E2E tests in TypeScript;
- Exploring the framework's core features and concepts, applying automation best practices to Mark;
- Generating regression test reports with image and video evidence;
- A continuous testing pipeline with Playwright running on GitHub Actions, controlling the execution flow with reports, screenshots, and metrics — without depending on running everything locally.

---

## 🗂️ Estrutura do Projeto / Project Structure

```
playwright-mark/
├── apps/
│   ├── api/        # Backend Node.js/Express + SQLite (porta/port 3333)
│   └── web/        # Frontend estático + proxy local-web-server (porta/port 8080)
├── start.bat        # Inicializa banco, API e frontend / Starts DB, API and frontend
├── stop.bat         # Encerra todos os processos Node.js / Stops all Node.js processes
└── README.md
```

> 🇧🇷 **Observação:** ignore qualquer pasta `__MACOSX` que apareça após descompactar o projeto — é um artefato gerado pelo sistema operacional e não faz parte da aplicação. A execução deve acontecer sempre a partir de `apps/api` e `apps/web`.
>
> 🇺🇸 **Note:** ignore any `__MACOSX` folder that appears after unzipping the project — it's an OS-generated artifact and not part of the application. Execution should always happen from `apps/api` and `apps/web`.

---

## 🔀 Como o Proxy Funciona / How the Proxy Works

**🇧🇷** O frontend faz requisições relativas para a rota `/tasks`. Se o `apps/web` for servido com um `http-server` comum, essas chamadas não são redirecionadas para a API e resultam em erros como `404`, `405` ou `Connection Refused`.

Para resolver isso, o `apps/web` usa o pacote [`local-web-server`](https://www.npmjs.com/package/local-web-server) (`ws`), configurado em `apps/web/lws.config.js` para redirecionar o tráfego de `/tasks` (porta `8080`) para a API (porta `3333`).

**🇺🇸** The frontend makes relative requests to the `/tasks` route. If `apps/web` is served with a plain `http-server`, those calls aren't forwarded to the API and result in errors like `404`, `405`, or `Connection Refused`.

To fix this, `apps/web` uses the [`local-web-server`](https://www.npmjs.com/package/local-web-server) package (`ws`), configured in `apps/web/lws.config.js` to redirect traffic from `/tasks` (port `8080`) to the API (port `3333`).

```js
module.exports = {
  port: 8080,
  rewrite: [
    {
      from: '/tasks',
      to: 'http://localhost:3333/tasks'
    },
    {
      from: '/tasks/(.*)',
      to: 'http://localhost:3333/tasks/$1'
    }
  ]
}
```

---

## ✅ Pré-requisitos / Prerequisites

- Node.js v18 ou superior / v18 or higher
- NPM instalado / NPM installed

## 📦 Instalação das Dependências / Installing Dependencies

```bash
# Na pasta da API / In the API folder
cd apps/api
npm install

# Na pasta do Frontend / In the Frontend folder
cd ../web
npm install
npm install -D local-web-server
```

---

## ▶️ Como Rodar o Projeto / How to Run the Project

### Opção 1 — Execução Automática (Windows) / Option 1 — Automatic Run (Windows)

**🇧🇷**
1. Dê um duplo clique no arquivo `start.bat` na raiz do projeto.
   - O script inicializa o banco de dados (`npm run db:init`), sobe a API na porta `3333` em uma janela de terminal e o servidor web na porta `8080` em outra.
2. Acesse a aplicação no navegador em `http://localhost:8080`.
3. Para desligar a API e o servidor web, execute o arquivo `stop.bat` (ele finaliza todos os processos `node.exe` em execução).

**🇺🇸**
1. Double-click the `start.bat` file at the project root.
   - The script initializes the database (`npm run db:init`), starts the API on port `3333` in one terminal window, and the web server on port `8080` in another.
2. Open the application in your browser at `http://localhost:8080`.
3. To shut down the API and web server, run `stop.bat` (it terminates all running `node.exe` processes).

### Opção 2 — Execução Manual / Option 2 — Manual Run

**🇧🇷**
1. **Banco de dados:** dentro de `apps/api`, rode `npm run db:init`.
2. **Backend (API):** em um terminal, na pasta `apps/api`, rode `npm run dev` (Porta `3333`).
3. **Frontend (Web):** em outro terminal, na pasta `apps/web`, rode `npx ws` (Porta `8080`, já com o proxy de `/tasks` configurado).
4. Acesse `http://localhost:8080` no navegador.

**🇺🇸**
1. **Database:** inside `apps/api`, run `npm run db:init`.
2. **Backend (API):** in one terminal, from `apps/api`, run `npm run dev` (port `3333`).
3. **Frontend (Web):** in another terminal, from `apps/web`, run `npx ws` (port `8080`, already with the `/tasks` proxy configured).
4. Open `http://localhost:8080` in your browser.

---

## 🧰 Scripts Auxiliares / Helper Scripts

| Script | Função / Function |
|---|---|
| `start.bat` | 🇧🇷 Inicializa o banco de dados, sobe a API (3333) e o frontend (8080) automaticamente · 🇺🇸 Initializes the database, starts the API (3333) and the frontend (8080) automatically |
| `stop.bat` | 🇧🇷 Encerra todos os processos Node.js em execução (API e Web) · 🇺🇸 Stops all running Node.js processes (API and Web) |

---

## 🗺️ Roadmap de Estudo / Study Roadmap

**🇧🇷** Progresso do que já foi aplicado neste projeto e do que ainda está por vir:

**🇺🇸** Progress of what has already been applied in this project and what's still coming:

### Fundamentos e primeiros testes / Fundamentals & first tests
- [x] Primeiro teste em Playwright / First Playwright test
- [x] Rodando testes com o navegador visível (não-headless) / Running tests with a visible browser (non-headless)
- [x] Debugando testes / Debugging tests
- [x] Padronização e indentação de código / Code formatting & indentation
- [x] Técnicas de busca de elementos com CSS Selectors / Element lookup techniques with CSS Selectors
- [x] Submissão de formulários HTML (bônus: XPath) / Submitting HTML forms (bonus: XPath)
- [x] Geração de dados dinâmicos com Faker / Dynamic data generation with Faker
- [x] Helper de consumo de API / API consumption helper
- [x] Importação de coleções JSON no Insomnia / Importing JSON collections into Insomnia
- [x] Validação do comportamento esperado / Validating expected behavior

### Aprimorando os testes / Improving the tests
- [ ] Testes independentes / Independent tests
- [ ] Modelagem de massa de testes com interfaces TypeScript / Modeling test data with TypeScript interfaces
- [ ] Comandos customizados (Helpers) / Custom commands (Helpers)
- [ ] Page Objects na prática / Page Objects in practice
- [ ] Boas práticas e fundamentos por trás da automação / Best practices and the fundamentals behind automation
- [ ] Trabalhando com Fixtures / Working with Fixtures
- [ ] XPath e CSS Selectors na prática / XPath and CSS Selectors in practice
- [ ] Reúso de código / Code reuse

### Configurações e boas práticas / Configuration & best practices
- [ ] Configuração de URL base / Base URL configuration
- [ ] URLs customizadas com dotenv / Custom URLs with dotenv
- [ ] Variáveis e constantes / Variables & constants
- [ ] Entendendo timeouts / Understanding timeouts
- [ ] Screenshots automáticos / Automatic screenshots
- [ ] Multi-browser, responsividade e testes em paralelo / Multi-browser, responsiveness & parallel testing
- [ ] Consolidação das habilidades de automação de QA / Consolidating QA automation skills

### Bônus: Testes contínuos / Bonus: Continuous testing
- [ ] Pipeline de testes contínuos com Playwright no GitHub Actions / Continuous testing pipeline with Playwright on GitHub Actions
- [ ] Relatórios, screenshots e métricas de execução / Execution reports, screenshots & metrics

---

## 🐛 Problemas Comuns / Common Issues

**🇧🇷**
- **Erro 404 / 405 / Connection Refused ao chamar `/tasks`:** verifique se o `apps/web` está sendo servido via `npx ws` (com `lws.config.js`) e não por um `http-server` genérico, e se a API está rodando na porta `3333`.
- **Pasta `__MACOSX` no repositório:** pode ser removida com segurança; é gerada apenas ao descompactar o projeto em ambiente macOS.

**🇺🇸**
- **404 / 405 / Connection Refused errors when calling `/tasks`:** check that `apps/web` is being served via `npx ws` (with `lws.config.js`) and not a generic `http-server`, and that the API is running on port `3333`.
- **`__MACOSX` folder in the repository:** safe to remove; it's only generated when unzipping the project on macOS.

---

## 🎯 Metodologia / Methodology

**🇧🇷** Este projeto segue uma metodologia mão na massa: cada conceito é aplicado diretamente em cenários reais de teste sobre o Mark, priorizando clareza, boas práticas e autonomia técnica na automação de testes de ponta a ponta.

**🇺🇸** This project follows a hands-on methodology: every concept is applied directly to real test scenarios against Mark, prioritizing clarity, best practices, and technical autonomy in end-to-end test automation.

---

<p align="center">
Feito com 💜 por Eduardo Mussulini · Made with 💜 by Eduardo Mussulini
</p>
