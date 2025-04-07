import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  received(data) {
    let notificationsContainer = document.getElementById("notifications");
    let newNotification = `
      <div class="alert alert-info shadow-sm p-2 rounded">
        <strong>${data.title}</strong><br>
        ${data.content} <br>
        <small>${data.created_at}</small>
      </div>`;
    notificationsContainer.insertAdjacentHTML("afterbegin", newNotification);
  }
});
