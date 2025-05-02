# ChangePhotos App – SwiftUI + Firebase Authentication

## Описание

Приложение, которое включает систему авторизации с поддержкой входа через email и Google, а также предоставляет пользователям инструменты для редактирования фотографий.

## SignIn / SignUp

Реализована система аутентификации с использованием **Firebase Authentication**, включая следующие возможности:

- **Вход по Email и паролю**  
  Пользователь может войти в аккаунт, введя свою электронную почту и пароль. Перед входом проверяется, подтверждён ли email.

- **Регистрация аккаунта по Email**  
  Новый пользователь может зарегистрироваться, указав email и пароль. После создания аккаунта ему отправляется письмо с подтверждением email. Без подтверждения вход будет невозможен.

- **Сброс пароля**  
  При необходимости пользователь может восстановить доступ к аккаунту, запросив ссылку для сброса пароля на указанный email.

- **Вход через Google**  
  Поддерживается безопасная авторизация через Google-аккаунт с использованием OAuth 2.0. Для входа используется официальный SDK Google Sign-In.

> Каждый способ входа и регистрации реализован с валидацией полей, обработкой ошибок и обратной связью для пользователя.


<table>
  <tr>
    <td>
      <a href="https://github.com/user-attachments/assets/c7d4a55d-9f2f-4c77-9a3b-e609bfb35924">
        <img src="https://github.com/user-attachments/assets/c7d4a55d-9f2f-4c77-9a3b-e609bfb35924" width="200"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/user-attachments/assets/cc7b41b0-8cba-4453-a9a5-24ab9acdd625">
        <img src="https://github.com/user-attachments/assets/cc7b41b0-8cba-4453-a9a5-24ab9acdd625" width="200"/>
      </a>
    </td>
        <td>
      <a href="https://github.com/user-attachments/assets/f92af175-65d1-4cac-bf2a-d7fa4c9a0e69">
        <img src="https://github.com/user-attachments/assets/f92af175-65d1-4cac-bf2a-d7fa4c9a0e69" width="200"/>
      </a>
    </td>
         <td>
      <a href="https://github.com/user-attachments/assets/c43e1e9c-0a71-4ce0-8243-8dba9e1ff77b">
        <img src="https://github.com/user-attachments/assets/c43e1e9c-0a71-4ce0-8243-8dba9e1ff77b" width="200"/>
      </a>
  </tr>
</table>

## Add Photo from image picker or camera

Приложение позволяет добавить фотографию двумя способами:
-  Сделать снимок с помощью камеры
-  Выбрать изображение из галереи

<table>
  <tr>
    <td>
      <a href="https://github.com/user-attachments/assets/f02c04ab-f643-4e85-83df-fb350f6f20cb">
        <img src="https://github.com/user-attachments/assets/f02c04ab-f643-4e85-83df-fb350f6f20cb" width="200"/>
      </a>
    </td>
  </tr>
</table>
