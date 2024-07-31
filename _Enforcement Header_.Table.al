table 50560 "Enforcement Header"
{
    Caption = 'Enforcement Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "No." <> '' then NoSeriesMgt.TestManual(ComplianceSetup."Enforcement Nos");
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(4; "Area of Enforcement"; Text[200])
        {
            Caption = 'Area of Enforcement';
            DataClassification = ToBeClassified;
        }
        field(5; "Personnel Encountered"; Text[100])
        {
            Caption = 'Personnel Encountered';
            DataClassification = ToBeClassified;
        }
        field(6; "Compliance Status"; Option)
        {
            Caption = 'Compliance Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Compliant, "Non Compliant";
        }
        field(7; "Action To Be Taken"; Option)
        {
            Caption = 'Action To Be Taken';
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Given timeline to achieve compliance", "Compliance corrected on the spot", "Proceed to Execution";
        }
        field(8; "Client Name"; Text[100])
        {
            Caption = 'Client Name';
            DataClassification = ToBeClassified;
        }
        field(9; "License Number"; Code[30])
        {
            Caption = 'License Number';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            Var
                Emp: Record Employee;
            begin
                Year:=DATE2DMY(Date, 3);
                UserSetup.Reset();
                UserSetup.Get(UserId);
                if UserSetup."User ID" = UserId then "Confiscation Officer No":=UserSetup."Employee No.";
                Emp.Reset();
                Emp.SetRange("No.", "Confiscation Officer No");
                if Emp.FindFirst()then begin
                    "Confiscation Officer Name":=emp."First Name" + ' ' + emp."Middle Name" + ' ' + Emp."Last Name";
                    "Officer Designation":=emp."Job Title2";
                    "Officer's Telephone No.":=Emp."Phone No.";
                end;
            end;
        }
        field(10; Volume; Decimal)
        {
            Caption = 'Volume';
            DataClassification = ToBeClassified;
        }
        field(11; "Means of Handling"; Option)
        {
            Caption = 'Means of Handling';
            DataClassification = ToBeClassified;
            OptionMembers = " ", "On Transit", Premise;
        }
        field(12; "Modes of handling"; Code[50])
        {
            Caption = 'Modes of handling';
            DataClassification = ToBeClassified;
            TableRelation = "Means of Handling Setup" where("Means of Handling"=field("Means of Handling"));
        }
        field(13; "Confiscation Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Confiscation Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Confiscation Time"; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(16; "Confiscation Venue"; Text[50])
        {
            Caption = 'Venue';
            DataClassification = ToBeClassified;
        }
        field(17; "Item confiscated"; Text[50])
        {
            Caption = 'Item confiscated';
            DataClassification = ToBeClassified;
        }
        field(18; "Confiscation Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(19; "Reasons for confiscation"; Text[500])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
        }
        field(20; "Confiscating Officer Signature"; Blob)
        {
            Caption = 'Confiscating Officer Signature';
            Subtype = Bitmap;
        }
        field(21; "Confiscation Owner Signature"; Blob)
        {
            Caption = 'Owner Signature';
            Subtype = Bitmap;
        }
        field(22; Disposal; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Prosecution Process", "Belonging to an Escapee";
        }
        field(23; "Disposal Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Forfeited, Destroyed;
        }
        field(24; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(27; County; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(28; Market; Text[20])
        {
            DataClassification = ToBeClassified;
        //TableRelation = Market;
        }
        field(29; Location; Text[20])
        {
            DataClassification = ToBeClassified;
        //TableRelation = Locations."Location Code";
        }
        field(30; "County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Nature of milk"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dairy Produce Setup";
        }
        field(32; "Confiscation Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "License Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", License, Permits;
        }
        field(34; "Confiscation Owner"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Where Disposed"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Type of Vehicle"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Type of Vehicle Setup";
        }
        field(37; "Vehicle Registrtion Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Containers seized"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Books or Records seized"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Any other item seized"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Client Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Officer Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Telephone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Unit of Measure"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(45; "Huduma Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "ID Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Disposal Certificate"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(48; "Officer's Telephone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Trader's Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Judgement Process"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Fine, Punishment;
            OptionCaption = ' ,Fine,Punishment';
        }
        field(51; "Confiscation Officer No"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                emp.SetRange("User ID", "Confiscation Officer No");
                if emp.FindFirst()then begin
                    "Confiscation Officer Name":=emp."First Name" + ' ' + emp."Middle Name" + ' ' + Emp."Last Name";
                    "Officer Designation":=emp."Job Title2";
                    "Officer's Telephone No.":=Emp."Phone No.";
                end;
            end;
        }
        field(52; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; Category; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "License and Permit Category"."License/Permit Category";
        }
        field(54; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Sub-County"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code" where(Station=Field(Branch));

            trigger OnValidate()
            var
                SubCounty: Record "Sub-County";
            begin
                SubCounty.SetRange("Sub-County Code", "Sub-County");
                if SubCounty.FindFirst()then begin
                    "Sub-County Name":=SubCounty.Name;
                end;
            end;
        }
        field(56; "Sub-County Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Date:=Today;
        Time:=Time;
        if not ComplianceSetup.Get()then begin
            ComplianceSetup.Init();
            ComplianceSetup.Insert();
        end;
        ComplianceSetup.Get();
        ComplianceSetup.TestField("Enforcement Nos");
        NoSeriesMgt.InitSeries(ComplianceSetup."Enforcement Nos", xRec."No. Series", Today, "No.", "No. Series");
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    ComplianceSetup: Record "Compliance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
