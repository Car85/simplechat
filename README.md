# SimpleChat Project

Welcome to the **SimpleChat** project! This project is a real-time chat application built with Elixir, Phoenix, and Phoenix LiveView. The application supports multiple users, real-time message updates, and user presence tracking.

## Features

- Real-time messaging
- User presence tracking
- Unique usernames generated using mnemonic slugs
- Message broadcasting using Phoenix PubSub
- Responsive design with TailwindCSS

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Elixir
- Phoenix
- Node.js
- PostgreSQL

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/Car85/simplechat.git
    cd simplechat
    ```

2. Install dependencies & compile:

    ```sh
    mix deps.get
    mix deps.compile

    ```

3. Start the Phoenix server:

    ```sh
    mix phx.server
    ```

4. Open your browser and navigate to `http://localhost:4000`.

## Usage

- Users are assigned unique usernames upon joining the chat room.
- Messages are displayed in real-time to all connected users.
- User presence is tracked, and notifications are displayed when users join or leave.

## TODO

### 🎨 UI/UX Enhancements

- [ ] **Assign Random Colors to Users**: Assign a unique, random color to each user's username, which will be displayed consistently in both the message list and the user list.
- [ ] **Dark Mode**: Implement a dark mode theme with a toggle button to switch between light and dark modes.

### 🛠️ Additional Features

- [ ] **Emoji Support**: Add support for users to send and display emojis in their messages.
- [ ] **File Sharing**: Enable users to share files within the chat.
- [ ] **Private Messaging**: Implement private messaging between users.
- [ ] **Message Reactions**: Allow users to react to messages with emojis.
- [ ] **User Profiles**: Create user profiles with customizable avatars and statuses.
- [ ] **Create a Chromium Extension**: Develop a Chromium extension that integrates with the SimpleChat application. This extension should allow users to interact with the chat directly from their browser toolbar, providing notifications for new messages and enabling quick access to the chat interface.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Phoenix Framework](https://www.phoenixframework.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [Elixir](https://elixir-lang.org/)

---

Happy hacking!


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
