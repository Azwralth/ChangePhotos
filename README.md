# ChangePhotos App – SwiftUI + Firebase Authentication

## Описание

Приложение, которое включает систему авторизации с поддержкой входа через email и Google, а также предоставляет пользователям инструменты для редактирования фотографий.

## Архитектура

Приложение построено с использованием архитектуры **MVVM**

**Combine** используется для связывания состояния UI с моделью. Используются **Publishers** для обновления интерфейса

**Async/Await** используется для работы с сетевыми запросами

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

## Add Photo from Image Picker or Camera

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

## Change Your Photo

После того как фотография добавлена, вы можете использовать различные инструменты для её редактирования:

- **Добавление фильтров при помощи CoreImage Filter**  
  Приложение предоставляет набор фильтров для изменения атмосферы и стиля изображения. Вы можете выбрать подходящий фильтр для создания нужного визуального эффекта.

- **Рисование при помощи PencilKit**  
  С помощью инструмента рисования вы можете добавлять элементы прямо на фото — линии, формы и другие графические объекты.

- **Масштабирование и поворот**  
  Изменяйте размер и ориентацию фотографии с помощью удобных инструментов масштабирования и поворота.

- **Добавление текста**  
  Добавляйте текстовые надписи с возможностью выбора шрифта, размера и цвета. Это полезно для создания мемов, цитат или подписей.

<table>
  <tr>
    <td>
      <a href="https://github.com/user-attachments/assets/f701da97-7e81-4ef3-b6d3-e98575480949">
        <img src="https://github.com/user-attachments/assets/f701da97-7e81-4ef3-b6d3-e98575480949" width="200"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/user-attachments/assets/a7826d57-432b-46f6-9268-a7c1ba2514be">
        <img src="https://github.com/user-attachments/assets/a7826d57-432b-46f6-9268-a7c1ba2514be" width="200"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/user-attachments/assets/18039390-82d8-4a21-ae03-6c6840823e96">
        <img src="https://github.com/user-attachments/assets/18039390-82d8-4a21-ae03-6c6840823e96" width="200"/>
      </a>
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/user-attachments/assets/84f5b4bb-6caa-4a2d-941e-59cc561afbdf">
        <img src="https://github.com/user-attachments/assets/84f5b4bb-6caa-4a2d-941e-59cc561afbdf" width="200"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/user-attachments/assets/58c4a28a-9d8b-4b4e-bb11-48e62120036c">
        <img src="https://github.com/user-attachments/assets/58c4a28a-9d8b-4b4e-bb11-48e62120036c" width="200"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/user-attachments/assets/ab77ded0-4507-44e0-af59-c2fb3821747f">
        <img src="https://github.com/user-attachments/assets/ab77ded0-4507-44e0-af59-c2fb3821747f" width="200"/>
      </a>
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/user-attachments/assets/e5874dac-95ee-4ea4-a8f0-85176cab95e0">
        <img src="https://github.com/user-attachments/assets/e5874dac-95ee-4ea4-a8f0-85176cab95e0" width="200"/>
      </a>
    </td>
  </tr>
</table>


