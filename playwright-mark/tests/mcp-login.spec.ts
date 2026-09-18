import { test, expect } from '@playwright/test'

test.describe('Acesso ao frontend do Mark', () => {
  test('deve acessar a URL do frontend e carregar a página corretamente', async ({ page }) => {
    const response = await page.goto('http://localhost:8080')

    // Valida que a requisição HTTP retornou sucesso (2xx)
    expect(response?.ok()).toBeTruthy()

    // Valida que o título da página carregou como esperado
    await expect(page).toHaveTitle('Gerencie suas tarefas com Mark L')

    // Valida que o corpo da página está visível, confirmando o carregamento
    await expect(page.locator('body')).toBeVisible()
  })
})
