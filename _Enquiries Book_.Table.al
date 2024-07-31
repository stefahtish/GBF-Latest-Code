table 50479 "Enquiries Book"
{
    fields
    {
        field(1; "Serial Number"; Code[10])
        {
            trigger OnValidate()
            begin
                if "Serial Number" <> xRec."Serial Number" then begin
                    RMSetup.Get;
                    NoSeriesMgt.TestManual(RMSetup."Enquiries Nos.");
                    "Serial Number":='';
                end;
            end;
        }
        field(2; "Name of Customer"; Text[150])
        {
        }
        field(3; "I.D No."; Integer)
        {
        }
        field(4; "SF No."; Code[10])
        {
        }
        field(5; "Phone Number"; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(6; "Complaint/Request Submitted"; Text[250])
        {
        }
        field(7; "Customer Remarks"; Text[250])
        {
        }
        field(10; "Satisfaction Level"; Option)
        {
            OptionMembers = Satisfied, "Not Satisfied";
        }
        field(11; Status; Option)
        {
            OptionMembers = Open, Forwarded, Receptionist, Closed;
        }
        field(12; Duration; DateFormula)
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Purpose of Visit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Private, Personal, Official;
            OptionCaption = ' ,Private,Personal,Official';
        }
        field(15; Appointment; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Yes, No;
            OptionCaption = ' ,Yes,No';
        }
        field(16; "Name of Officer to be seen"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Place From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Date of Visit"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Visitor's Signature"; Blob)
        {
            Subtype = Bitmap;
        }
        field(21; "Signature Officer to be seen"; Blob)
        {
            Subtype = Bitmap;
        }
        field(22; "Officer to be seen no."; Code[20])
        {
            Caption = 'Officer To Be Seen No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Employee.Reset();
                Employee.SetRange("No.", "Officer to be seen no.");
                if Employee.FindFirst()then begin
                    "Officer's Email":=Employee."Company E-Mail";
                    "Name of Officer to be seen":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(23; "Refererred By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Company From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Visiting Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(28; "Officer's Decision"; Option)
        {
            OptionMembers = " ", Accepted, Rejected;
            OptionCaption = ' ,Accepted,Rejected';
            DataClassification = ToBeClassified;
        }
        field(29; "Officer's Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "TimeIn"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "TimeOut"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Assign Remarks"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Receptionist Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Receptionist UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Officer's Decision Time"; Time)
        {
        }
        field(36; "Visitor type"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Company, Self;
            OptionCaption = ' ,Company,Self';
        }
        field(37; Gender; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Male, Female;
            OptionCaption = ' ,Male,Female';
        }
    }
    keys
    {
        key(Key1; "Serial Number")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Serial Number" = '' then begin
            RMSetup.Get;
            RMSetup.TestField(RMSetup."Enquiries Nos.");
            NoSeriesMgt.InitSeries(RMSetup."Enquiries Nos.", xRec."No. Series", 0D, "Serial Number", "No. Series");
        end;
        "Receptionist UserID":=UserId;
        UserSetup.Reset();
        UserSetup.SetRange("User ID", "Receptionist UserID");
        if UserSetup.FindFirst()then begin
            Employee.Reset();
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst()then "Receptionist Email":=Employee."Company E-Mail";
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    RMSetup: Record "Marketing Setup";
    UserSetup: Record "User Setup";
    Employee: Record Employee;
}
