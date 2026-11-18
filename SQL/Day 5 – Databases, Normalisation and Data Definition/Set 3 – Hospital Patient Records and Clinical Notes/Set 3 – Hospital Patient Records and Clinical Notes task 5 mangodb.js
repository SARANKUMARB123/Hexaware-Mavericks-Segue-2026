use("HospitalManagementDB");

// CREATE CLINICALNOTES COLLECTION WITH VALIDATION

db.createCollection("ClinicalNotes", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["patientId", "patientName", "doctorName", "diagnosis"],
      properties: {
        patientId: {
          bsonType: "int"
        },
        patientName: {
          bsonType: "string"
        },
        doctorName: {
          bsonType: "string"
        },
        diagnosis: {
          bsonType: "string"
        },
        prescription: {
          bsonType: "string"
        },
        notes: {
          bsonType: "string"
        },
        visitDate: {
          bsonType: "date"
        }
      }
    }
  }
});

// INSERT DOCUMENTS OF TWO DIFFERENT SHAPES

db.ClinicalNotes.insertMany([

{
  patientId: 1,
  patientName: "Arun Kumar",
  doctorName: "Dr. Arun",
  diagnosis: "Fever",
  prescription: "Paracetamol",
  notes: "Drink plenty of water",
  visitDate: new Date("2026-10-01")
},

{
  patientId: 2,
  patientName: "Priya Sharma",
  doctorName: "Dr. Priya",
  diagnosis: "Migraine",
  prescription: "Pain Killer",
  visitDate: new Date("2026-10-03")
},

{
  patientId: 3,
  patientName: "Rahul Singh",
  doctorName: "Dr. Rahul",
  diagnosis: "Fracture",
  notes: "Use arm support",
  visitDate: new Date("2026-10-05")
},

{
  patientId: 4,
  patientName: "Sneha Rao",
  doctorName: "Dr. Sneha",
  diagnosis: "Skin Allergy",
  prescription: "Ointment",
  notes: "Avoid dust"
},

{
  patientId: 5,
  patientName: "Vijay Kumar",
  doctorName: "Dr. Vijay",
  diagnosis: "Cold",
  prescription: "Cough Syrup"
},

{
  patientId: 6,
  patientName: "Meena Devi",
  doctorName: "Dr. Meena",
  diagnosis: "Ear Infection",
  notes: "Review after one week"
},

{
  patientId: 7,
  patientName: "Karthik Raj",
  doctorName: "Dr. Karthik",
  diagnosis: "Cancer Checkup",
  prescription: "Medication",
  notes: "Routine monitoring",
  visitDate: new Date("2026-10-12")
},

{
  patientId: 8,
  patientName: "Anitha Roy",
  doctorName: "Dr. Anitha",
  diagnosis: "Pregnancy",
  prescription: "Vitamin Tablets"
},

{
  patientId: 9,
  patientName: "Suresh Babu",
  doctorName: "Dr. Suresh",
  diagnosis: "Kidney Stone",
  notes: "Drink more water"
},

{
  patientId: 10,
  patientName: "Deepa Nair",
  doctorName: "Dr. Deepa",
  diagnosis: "Diabetes",
  prescription: "Insulin",
  visitDate: new Date("2026-10-20")
}

]);

// VIEW ALL DOCUMENTS

db.ClinicalNotes.find();

// QUERY BY DIAGNOSIS

db.ClinicalNotes.find({
  diagnosis: "Fever"
});