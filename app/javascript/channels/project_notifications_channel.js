import consumer from "channels/consumer"


let subscription = null;

function subscribeToProjectNotifications(projectId) {
  if (subscription) {
    subscription.unsubscribe();  // Clean up old subscription
  }

  subscription = consumer.subscriptions.create(
    { channel: "ProjectNotificationsChannel", project_id: projectId },
    {
      received(data) {
        console.log("Received data: ")
        Turbo.renderStreamMessage(data)
      }
    }
  )
}

function handleTurboLoad() {
  const projectElement = document.querySelector("[data-project-id]");
  if (projectElement) {
    const projectId = projectElement.dataset.projectId;
    subscribeToProjectNotifications(projectId);
  }
}

// Subscribe to new project channel on page load
document.addEventListener("turbo:load", function() {
  const projectElement = document.querySelector("[data-project-id]");
  if (projectElement) {
    const projectId = projectElement.dataset.projectId;
    subscribeToProjectNotifications(projectId);
  }
})

// Unsubscribe before the next page renders (to prevent memory leaks)
document.addEventListener("turbo:before-render", function() {
  if (subscription) {
    subscription.unsubscribe();
  }
});

document.addEventListener('turbo:submit-end', (event) => {
  const form = document.getElementById('comment-form');
  const textArea = document.getElementById('comment_content');

  if (form && event.target === form) {
    textArea.value = '';
  }
})

