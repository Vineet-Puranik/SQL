BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Doctor" (
	"Doctor_id"	INTEGER,
	"DFname"	TEXT,
	"DLname"	TEXT,
	"DCell_no"	INTEGER,
	PRIMARY KEY("Doctor_id")
);
CREATE TABLE IF NOT EXISTS "Drug" (
	"UPN"	INTEGER,
	"Dname"	TEXT,
	"Generic"	TEXT,
	"Description"	TEXT,
	"Dunit"	TEXT,
	"Dosage"	INTEGER,
	"Dform"	TEXT,
	"Cost"	REAL,
	"Price"	REAL,
	PRIMARY KEY("UPN")
);
CREATE TABLE IF NOT EXISTS "Prescription" (
	"Pid"	INTEGER,
	"DrugUPN"	INTEGER,
	"Quantity"	INTEGER,
	"Punit"	TEXT,
	"Eff_date"	TEXT,
	"Exp_date"	TEXT,
	"Total_refill"	INTEGER,
	"Auto_refill"	TEXT,
	"Refill_used"	INTEGER,
	"Instructions"	TEXT,
	"Student_id"	INTEGER,
	"Doctor_id"	INTEGER,
	PRIMARY KEY("Pid")
);
CREATE TABLE IF NOT EXISTS "Refill" (
	"Prescription_id"	INTEGER,
	"R_date"	TEXT,
	PRIMARY KEY("Prescription_id","R_date")
);
CREATE TABLE IF NOT EXISTS "Student" (
	"Sid"	INTEGER,
	"Fname"	TEXT,
	"Lname"	TEXT,
	"Cell_no"	TEXT,
	"DOB"	TEXT,
	"Gender"	TEXT,
	"HealthPlan_id"	TEXT,
	PRIMARY KEY("Sid")
);
CREATE TABLE IF NOT EXISTS "Health_Plan" (
	"Plan_id"	TEXT,
	"Pname"	TEXT,
	PRIMARY KEY("Plan_id")
);
INSERT INTO "Doctor" VALUES (1,'David','Allen',5058840542);
INSERT INTO "Doctor" VALUES (2,'Patricia','Freitag',9288884178);
INSERT INTO "Doctor" VALUES (3,'Gene','Gramann',9284881741);
INSERT INTO "Doctor" VALUES (4,'Roxanna','Jurski',4358871818);
INSERT INTO "Doctor" VALUES (5,'Robert','Trevino',9704297475);
INSERT INTO "Doctor" VALUES (6,'Sara','Westenberg',4353214789);
INSERT INTO "Doctor" VALUES (7,'James','Wilson',4351899874);
INSERT INTO "Doctor" VALUES (8,'Antonio','Zamarron',4358871818);
INSERT INTO "Doctor" VALUES (9,'Joshua','Warric',5058840542);
INSERT INTO "Doctor" VALUES (10,'Gunther','Loke',9284494174);
INSERT INTO "Doctor" VALUES (11,'Niel','Chah',4168888888);
INSERT INTO "Drug" VALUES (102,'Ampicillin','TRUE','Antibiotic','Pill',250,'mg',0.75,1.45);
INSERT INTO "Drug" VALUES (121,'Tolbutamide','FALSE','Bacterial infections','Pill',2,'mcg',0.24,0.9);
INSERT INTO "Drug" VALUES (224,'Avatocin','FALSE','Allergies','Pill',100,'mg',0.65,1.4);
INSERT INTO "Drug" VALUES (247,'Acebutolol hydrochloride','FALSE','Arthritis','Pill',400,'mg',0.55,1.1);
INSERT INTO "Drug" VALUES (256,'Dseurton','TRUE','High blood pressure','Pill',175,'mg',0.6,1.2);
INSERT INTO "Drug" VALUES (289,'Levothyroxine','TRUE','Thyroid disorders','Pill',25,'mg',0.7,1.4);
INSERT INTO "Drug" VALUES (311,'Dyotex','FALSE','Tonsillitis','Bottle',2,'tsp',0.25,1.05);
INSERT INTO "Drug" VALUES (366,'Phalastat','FALSE','Allergies','Bottle',1,'tsp',0.75,1.6);
INSERT INTO "Drug" VALUES (398,'Clonazepam','FALSE','Epiliepsy','Pill',4,'mcg',0.65,1.2);
INSERT INTO "Drug" VALUES (412,'Epronix','FALSE','Pain','Pill',500,'mg',0.85,1.5);
INSERT INTO "Drug" VALUES (444,'Syocil','TRUE','Diabetes','Pill',120,'mg',0.45,1.1);
INSERT INTO "Drug" VALUES (452,'Diazapam','TRUE','Anxiety','Pill',5,'mg',0.45,1.12);
INSERT INTO "Drug" VALUES (467,'Glimepiride','TRUE','Diabetes','Pill',2,'mg',0.25,0.9);
INSERT INTO "Drug" VALUES (523,'Xeroflarol','TRUE','Acid reflux','Bottle',1,'tsp',0.5,1.05);
INSERT INTO "Drug" VALUES (524,'Cefixime','TRUE','Antihistamine','Pill',400,'mg',0.95,1.6);
INSERT INTO "Drug" VALUES (566,'Quentix','TRUE','High blood pressure','Pill',50,'mg',0.5,1.25);
INSERT INTO "Drug" VALUES (587,'Haloperidol','FALSE','Diuretic','Pill',6,'mcg',0.7,1.3);
INSERT INTO "Drug" VALUES (622,'Tiron','FALSE','Beta blocker','Pill',150,'mcg',0.75,1.3);
INSERT INTO "Drug" VALUES (642,'Montelukast sodium','TRUE','Acne','Pill',10,'mcg',0.32,0.9);
INSERT INTO "Drug" VALUES (644,'Hyometadol','FALSE','Asthma','Bottle',2,'tsp',0.65,1.35);
INSERT INTO "Drug" VALUES (654,'Warfarin Sodium','TRUE','Bronchitis','Pill',4,'mg',0.65,1.4);
INSERT INTO "Drug" VALUES (711,'Nvalax','TRUE','Depression','Pill',200,'mg',0.3,0.9);
INSERT INTO "Drug" VALUES (732,'Albuterol Sulfate','TRUE','Asthma','Pill',2,'mg',0.3,0.95);
INSERT INTO "Drug" VALUES (741,'Almotriptan','TRUE','Conjunctivitis','Pill',6.25,'mg',0.14,0.87);
INSERT INTO "Drug" VALUES (828,'Myobuterol','TRUE','Antibiotic','Bottle',1,'tsp',0.55,1.6);
INSERT INTO "Drug" VALUES (852,'Oxaprozin','TRUE','Anti-inflammatory','Pill',1200,'mg',0.6,1.25);
INSERT INTO "Drug" VALUES (878,'Didanosine','TRUE','Sinus infection','Pill',200,'mg',0.65,1.12);
INSERT INTO "Drug" VALUES (932,'Tvalaxec','TRUE','Antihistamine','Bottle',2,'tsp',0.5,1.0);
INSERT INTO "Drug" VALUES (972,'Rivastigmine tartrate','TRUE','ADHD','Pill',4.4,'mg',0.4,1.05);
INSERT INTO "Drug" VALUES (987,'Rizatriptan Benzoate','FALSE','Pain','Pill',6,'mg',0.47,1.1);
INSERT INTO "Prescription" VALUES (1,224,1,'mg','2007-09-10','2008-06-10',2,'TRUE',0,'1 pill every 6 hours',17,3);
INSERT INTO "Prescription" VALUES (2,828,1,'ml','2007-12-15','2008-12-11',3,'FALSE',1,'1 teaspoon every 4 hours',18,1);
INSERT INTO "Prescription" VALUES (3,711,1,'mg','2008-06-21','2008-07-30',5,'FALSE',0,'2 pills daily',23,10);
INSERT INTO "Prescription" VALUES (4,256,1,'mg','2008-01-10','2008-10-24',2,'TRUE',0,'2 pills every 12 hours',19,10);
INSERT INTO "Prescription" VALUES (5,398,1,'mg','2007-09-10','2008-09-12',3,'TRUE',1,'2 pills every 6 hours with food',19,10);
INSERT INTO "Prescription" VALUES (6,932,1,'ml','2008-01-24','2008-09-22',2,'TRUE',1,'1 teaspoon every 6 hours',14,5);
INSERT INTO "Prescription" VALUES (7,311,1,'ml','2007-09-24','2008-11-25',4,'TRUE',0,'2 teaspoons full every 4 hours',21,7);
INSERT INTO "Prescription" VALUES (8,444,1,'mg','2007-02-24','2008-01-20',4,'TRUE',0,'2 pills every 6 hours with food',1,1);
INSERT INTO "Prescription" VALUES (9,398,1,'mg','2007-04-15','2008-06-11',4,'TRUE',1,'1 pill every 5 hours with food',4,8);
INSERT INTO "Prescription" VALUES (10,247,1,'mg','2008-01-16','2008-12-18',4,'TRUE',0,'2 pills daily',1,3);
INSERT INTO "Prescription" VALUES (11,732,1,'mg','2007-07-06','2008-06-24',4,'TRUE',0,'2 pills every 5 hours as needed',24,6);
INSERT INTO "Prescription" VALUES (12,828,1,'ml','2007-03-14','2008-01-22',2,'TRUE',0,'1 teaspoon every 4 hours',20,8);
INSERT INTO "Prescription" VALUES (13,398,1,'mg','2007-05-16','2008-07-11',4,'TRUE',0,'1 pill every 5 hours with food',8,9);
INSERT INTO "Prescription" VALUES (14,932,1,'ml','2007-09-24','2008-04-16',3,'TRUE',0,'1 teaspoon every 6 hours',10,3);
INSERT INTO "Prescription" VALUES (15,732,1,'mg','2007-08-14','2008-07-31',4,'TRUE',0,'2 pills every 6 hours',11,2);
INSERT INTO "Prescription" VALUES (16,828,1,'ml','2007-08-13','2008-07-14',4,'TRUE',2,'1 teaspoon every 4 hours',15,7);
INSERT INTO "Prescription" VALUES (17,366,1,'ml','2008-02-02','2008-12-15',3,'FALSE',0,'2 teaspoons full every 6 hours',22,5);
INSERT INTO "Prescription" VALUES (18,366,1,'ml','2008-02-02','2008-12-15',3,'FALSE',0,'2 teaspoons full every 6 hours',22,5);
INSERT INTO "Prescription" VALUES (19,878,1,'mg','2008-06-13','2008-12-12',2,'TRUE',0,'2 pills every 4 hours with food',4,8);
INSERT INTO "Prescription" VALUES (20,642,1,'mg','2007-07-08','2008-01-06',4,'TRUE',0,'2 pills daily',11,2);
INSERT INTO "Prescription" VALUES (21,102,1,'mg','2008-05-02','2008-10-30',3,'TRUE',0,'1 pill every 5 hours with food',1,4);
INSERT INTO "Prescription" VALUES (22,523,1,'ml','2008-01-14','2008-08-19',3,'TRUE',1,'2 teaspoons full every 5 hours',21,7);
INSERT INTO "Prescription" VALUES (23,366,1,'ml','2007-04-15','2008-03-03',3,'TRUE',0,'3 teaspoons full every 6 hours',18,9);
INSERT INTO "Prescription" VALUES (24,711,1,'mg','2008-01-06','2008-08-09',3,'FALSE',1,'2 pills daily',14,6);
INSERT INTO "Prescription" VALUES (25,878,1,'mg','2007-05-01','2008-04-18',4,'TRUE',1,'2 pills every 4 hours with food',23,10);
INSERT INTO "Prescription" VALUES (26,311,1,'ml','2007-07-17','2008-03-09',3,'TRUE',0,'2 teaspoons full every 4 hours',11,4);
INSERT INTO "Refill" VALUES (1,'2007/12/11');
INSERT INTO "Refill" VALUES (2,'2008/4/14');
INSERT INTO "Refill" VALUES (2,'2008/6/1');
INSERT INTO "Refill" VALUES (3,'2008/7/1');
INSERT INTO "Refill" VALUES (4,'2008/6/21');
INSERT INTO "Refill" VALUES (5,'2008/1/12');
INSERT INTO "Refill" VALUES (5,'2008/3/11');
INSERT INTO "Refill" VALUES (6,'2008/6/3');
INSERT INTO "Refill" VALUES (6,'2008/8/25');
INSERT INTO "Refill" VALUES (7,'2008/5/14');
INSERT INTO "Refill" VALUES (8,'2008/3/18');
INSERT INTO "Refill" VALUES (8,'2008/6/1');
INSERT INTO "Refill" VALUES (9,'2008/4/14');
INSERT INTO "Refill" VALUES (9,'2008/10/11');
INSERT INTO "Refill" VALUES (10,'2008/3/11');
INSERT INTO "Refill" VALUES (10,'2008/6/21');
INSERT INTO "Refill" VALUES (11,'2007/11/1');
INSERT INTO "Refill" VALUES (12,'2008/1/3');
INSERT INTO "Refill" VALUES (13,'2007/9/29');
INSERT INTO "Refill" VALUES (14,'2007/6/10');
INSERT INTO "Refill" VALUES (15,'2007/4/22');
INSERT INTO "Refill" VALUES (15,'2007/11/13');
INSERT INTO "Refill" VALUES (16,'2007/11/16');
INSERT INTO "Refill" VALUES (16,'2008/2/14');
INSERT INTO "Refill" VALUES (17,'2007/8/1');
INSERT INTO "Refill" VALUES (17,'2008/2/21');
INSERT INTO "Refill" VALUES (18,'2007/12/23');
INSERT INTO "Refill" VALUES (19,'2007/9/12');
INSERT INTO "Refill" VALUES (19,'2007/12/14');
INSERT INTO "Refill" VALUES (20,'2008/1/16');
INSERT INTO "Refill" VALUES (21,'2007/12/23');
INSERT INTO "Refill" VALUES (21,'2008/2/14');
INSERT INTO "Refill" VALUES (21,'2008/5/16');
INSERT INTO "Refill" VALUES (22,'2007/6/23');
INSERT INTO "Refill" VALUES (23,'2008/6/11');
INSERT INTO "Refill" VALUES (23,'2008/9/18');
INSERT INTO "Refill" VALUES (24,'2008/2/15');
INSERT INTO "Refill" VALUES (25,'2007/9/1');
INSERT INTO "Refill" VALUES (25,'2007/11/30');
INSERT INTO "Refill" VALUES (26,'2007/12/31');
INSERT INTO "Refill" VALUES (26,'2008/2/1');
INSERT INTO "Student" VALUES (1,'Ted','Williams','(970) 644-1214','1984/12/11','M','4983-SR');
INSERT INTO "Student" VALUES (4,'Steven','Nuggent','4351224545','1986/10/12','M','MED');
INSERT INTO "Student" VALUES (8,'Sonia','Cardenas','9285515547','1988/4/12','F','MED');
INSERT INTO "Student" VALUES (10,'Jonathan','Cardenas','9285515547','2004/8/22','M','MED');
INSERT INTO "Student" VALUES (11,'Paula','Hargus','5057441889','1970/6/11','F','SA-87');
INSERT INTO "Student" VALUES (14,'Mary','Ambrose','4354441233','1980/4/15','F','SLCH-01');
INSERT INTO "Student" VALUES (15,'Gina','Mercado','9705143212','1979/6/17','F','4983-SR');
INSERT INTO "Student" VALUES (17,'Maria','Gabel','9702234157','1980/8/12','F','4983-SR');
INSERT INTO "Student" VALUES (18,'Anders','Kroll','5054996541','1984/9/11','M','MED');
INSERT INTO "Student" VALUES (19,'Dusty','Springfield','4356931212','1990/4/5','M','001-GASW');
INSERT INTO "Student" VALUES (20,'Kevin','Bacon','4354778989','1990/6/22','M','001-GASW');
INSERT INTO "Student" VALUES (21,'Cesar','Romero','9706312222','1987/1/14','M','4983-SR');
INSERT INTO "Student" VALUES (22,'Jose','Hernandez','5054986478','1987/6/30','F','SA-87');
INSERT INTO "Student" VALUES (23,'Jennifer','Holiday','9288883545','1989/11/21','F','MED');
INSERT INTO "Student" VALUES (24,'Kimberley','Smith','9286472477','1989/1/16','F','MED');
INSERT INTO "Health_Plan" VALUES ('000WCH','WeCare Health');
INSERT INTO "Health_Plan" VALUES ('001-GASW','Great American  Southwest Health');
INSERT INTO "Health_Plan" VALUES ('4983-SR','Southern Rocky Mountains Health Plan');
INSERT INTO "Health_Plan" VALUES ('MED','Medicare');
INSERT INTO "Health_Plan" VALUES ('SA-87','Santa Ana Health');
INSERT INTO "Health_Plan" VALUES ('SLCH-01','Salt Lake Community Health');
COMMIT;
