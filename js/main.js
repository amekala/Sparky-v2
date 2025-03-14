// Sparky Chat Application JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Chat functionality
    const inputBox = document.querySelector('.input-box');
    const sendButton = document.querySelector('.send-button');
    const chatContainer = document.querySelector('.chat-container');

    function sendMessage() {
        if (inputBox && inputBox.value.trim() !== '') {
            const message = inputBox.value.trim();
            
            // Create user message element
            const userMessageDiv = document.createElement('div');
            userMessageDiv.classList.add('message', 'user-message');
            userMessageDiv.textContent = message;
            
            // Add timestamp
            const timeDiv = document.createElement('div');
            timeDiv.classList.add('message-time');
            const now = new Date();
            timeDiv.textContent = now.getHours() + ':' + now.getMinutes().toString().padStart(2, '0');
            userMessageDiv.appendChild(timeDiv);
            
            // Create clearfix
            const clearfix = document.createElement('div');
            clearfix.classList.add('clearfix');
            
            // Add to chat
            chatContainer.appendChild(userMessageDiv);
            chatContainer.appendChild(clearfix);
            
            // Clear input
            inputBox.value = '';
            
            // Scroll to bottom
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
    }

    if (sendButton) {
        sendButton.addEventListener('click', sendMessage);
    }

    if (inputBox) {
        inputBox.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    }
    
    // Add click event listeners to conversation starter cards if they exist
    const starterCards = document.querySelectorAll('.starter-card');
    if (starterCards) {
        starterCards.forEach(card => {
            card.addEventListener('click', function() {
                // Get the text content of the card (excluding any spans inside)
                const cardText = this.childNodes[0].textContent.trim();
                
                // Create a mock user message with this text
                const userMessageDiv = document.createElement('div');
                userMessageDiv.classList.add('message', 'user-message');
                userMessageDiv.textContent = cardText;
                
                // Add timestamp
                const timeDiv = document.createElement('div');
                timeDiv.classList.add('message-time');
                const now = new Date();
                timeDiv.textContent = now.getHours() + ':' + now.getMinutes().toString().padStart(2, '0');
                userMessageDiv.appendChild(timeDiv);
                
                // Create clearfix
                const clearfix = document.createElement('div');
                clearfix.classList.add('clearfix');
                
                // Add to chat
                chatContainer.appendChild(userMessageDiv);
                chatContainer.appendChild(clearfix);
                
                // Scroll to bottom
                chatContainer.scrollTop = chatContainer.scrollHeight;
            });
        });
    }
}); 