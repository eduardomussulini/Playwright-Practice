import { test, expect } from '@playwright/test'

test('deve poder cadastrar uma nova tarefa', async ({ page }) => {
    await page.goto('http://localhost:8080')

    await page.fill('input[class*=InputNewTask]', 'Ler um livro de TypeScript')

    await expect (page.locator('//a[contains(@class,"navigation-button w-button")]')).toBeVisible()
    
    await page.click('//a[contains(@class,"navigation-button w-button")]')

})