# smart_class_app

A new Flutter project.

                +----------------------+
                |         Start         |
                +-----------+----------+
                            |
                +-----------v-----------+
                |       User Login       |
                +-----------+------------+
                            |
                            v
                +-----------v-----------+
                |       Main Menu        |
                +-----------+------------+
        +---------+----+----+----+--------+
        |         |         |         |    |
        v         v         v         v    v
+-------+---+ +---+---+ +---+---+ +---+---+ +---+---+
| Desktop  | |Scheduling| | Chatbot | | Voice Rec | | Smart    |
| Interface| | & Mgmt   | |         | | & Notes  | | Controls |
+---+-------+ +---+-----+ +---+-----+ +---+-----+ +---+-----+
    |             |           |           |           |
    v             v           v           v           v
+---+---+     +---+---+   +---+---+   +---+---+   +---+---+
|Resource|    | Class   | | Initiate| | Record  | | IoT Data|
|Sharing |    | Scheduling| | Chatbot| | Lecture | | Collect.|
+---+---+     +---+---+   +---+---+   +---+---+   +---+---+
    |             |           |           |           |
    v             v           v           v           v
+---+---+     +---+---+   +---+---+   +---+---+   +---+---+
|Quiz Mgmt|   |Session  | | NLP Proc| |Transcribe| | Adjust |
+---+---+ |   | Mgmt    | | essing  | | & Store | | HVAC & |
    |     |   +---+---+ | +---+---+ | +---+---+ | Lighting|
    v     |       |     |     |     |     |     |          |
+---+---+ |       v     |     v     |     v     |          v
| Mobile | | +---+---+  | +---+---+ | +---+---+ | +---+---+
| Usage  | | | Resource| | Analytics| | Edit/Save| | Monitor|
| Monitor| | | Alloc.  | | & Respond| |         | | Occupancy|
+---+---+ | +---+---+  | +---+---+ | +---+---+ | +---+---+
          |     |      |           |           |          |
          v     v      v           v           v          v
     +----+----+---+---+---+---+---+---+---+---+---+---+---+
     |                   Database Management               |
     | +---+---+ +---+---+ +---+---+ +---+---+ +---+---+ +---+---+ |
     | | Local  | | Local  | | Local  | | Local  | | Local  | | Sync    | |
     | | Resource| | Schedule| | Chatbot | | Notes   | | Controls| | to DB  | |
     | | Storage | | Storage | | Storage | | Storage | | Storage | | Periodic| |
     +----+----+---+---+---+---+---+---+---+---+---+---+---+---+
                          |
                          v
                +---------v-----------+
                |         End          |
                +----------------------+
