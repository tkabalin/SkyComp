
<img width="250" alt="SkyComp Logo" src="https://github.com/user-attachments/assets/c43c5390-c885-4dd7-9037-f7f599d7dd8f" />

# SkyComp - Grade 11 Practical Assessment Task (PAT)

This project is a desktop application designed to manage and run knockout-style tournaments. It serves as a comprehensive planner for event organisers to create events, manage participants, and track results in real-time, while also providing a portal for participants to view their performance history.

## Features

### 🛠️ Organiser

* **Secure Authentication:** Create a new account or log in via email, password, and CAPTCHA.
* **Event Management:** Start a new tournament or continue managing a previously created event.
* **Participant Management:** Register new participants (with name, gender, DOB) into the database or select existing participants for an event.
* **Data Entry:** Enter qualification times to seed the top 8 participants into the knockout bracket.
* **Live Tournament Bracket:** View a visual representation of the tournament (Quarter-finals, Semi-finals, Finals) that updates as round times are entered.
* **Results Capture:** Enter times for each knockout round to automatically advance winners.
* **Database Management:** Edit participant details (name, DOB, etc.) or event details directly from the organiser panel.
* **Leaderboard Generation:** Output a final leaderboard as a text file once the tournament is complete.

### 👤 Participant

* **Secure Login:** Authenticate using a unique **ParticipantID** and CAPTCHA.
* **View Personal Details:** Check personal information (name, gender, DOB) stored in the system (read-only).
* **View Past Results:** Access a historical log of all events participated in and the results/times achieved in each.

## Application Forms

The application is built around seven main forms:

* **frmLogin:** Authenticates Organisers (email/password) or Participants (ParticipantID). Includes CAPTCHA validation.
* **frmCreateAccount:** Allows new Organisers to register a new account with validation.
* **frmSelectEvent:** Prompts the Organiser to either start a new event or select an existing one to continue.
* **frmSelectParticipants:** An interface for Organisers to add new participants to the database or select at least 8 registered participants for the current event.
* **frmQualification:** A screen for the Organiser to input the qualification times for all selected participants.
* **frmOrganiser:** The main dashboard for event management, featuring two tabs:
    * **Edit Tab:** Allows for viewing, searching, sorting, and updating participant and event data.
    * **View Tab:** Displays the live tournament bracket, captures round-by-round results, and generates the final leaderboard.
* **frmParticipant:** A read-only screen for Participants to view their personal details and a grid of their past event results.

## User Interface

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d7e0a2ae-c243-465c-89b8-0cc2d0833cdb" alt="Login" height="250"></td>
    <td><img src="https://github.com/user-attachments/assets/1a467697-e09e-46e7-93de-87d4de35dee7" alt="Create Account" height="250"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/7133480b-4d2a-44e3-858a-804c8151ff81" alt="Select Event" height="250"></td>
    <td><img src="https://github.com/user-attachments/assets/b883df5c-7c9f-4f37-ad31-4deb57a0d4be" alt="Select Participants (New)" height="250"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/be161924-54fc-4d03-81e3-beba681c5b93" alt="Qualification" height="250"></td>
    <td><img src="https://github.com/user-attachments/assets/cd6be4c9-e7ea-4306-bccd-0a48ab06640f" alt="Organiser (Capture Results)" height="250"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/509961c5-878d-49d4-bd15-bbfdff47c109" alt="Organiser (Edit Event)" height="250"></td>
    <td><img src="https://github.com/user-attachments/assets/42bfe319-ea7a-40c0-bdaa-2e65f5369d21" alt="Participant" height="250"></td>
  </tr>
</table>


## How to Run the Program

A pre-compiled executable is available in the repository.

1.  Download or clone the repository.
2.  Navigate to the `Win32/Debug` folder.
3.  Run `SkyComp_p.exe`.


## License

This project is protected by copyright. See `LICENSE.md` for full details.
