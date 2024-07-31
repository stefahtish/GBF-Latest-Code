table 50222 "Training Request"
{
    DrillDownPageId = "Training Request List";
    LookupPageId = "Training Request List";

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(2; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(3; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Job Title";
                    "Salary Scale" := Employee."Salary Scale";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Department Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(8; Designation; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(9; Period; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(10; "No. Of Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(11; "Training Insitution"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(12; Venue; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual - Commitment;
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(13; "Tuition Fee"; Decimal)
        {
            CalcFormula = Sum("Employees Travelling"."Tuition Fee" WHERE("Request No." = FIELD("Request No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                    "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                    IF Status<>Status::Open THEN
                    ERROR('Once document has been released it cannot be edited!');
                    */
            end;
        }
        field(14; "Per Diem"; Decimal)
        {
            CalcFormula = Sum("Employees Travelling"."Per Diem" WHERE("Request No." = FIELD("Request No.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                    "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                    IF Status<>Status::Open THEN
                    ERROR('Once document has been released it cannot be edited!');
                    */
            end;
        }
        field(15; "Air Ticket"; Decimal)
        {
            CalcFormula = Sum("Employees Travelling"."Air Ticket" WHERE("Request No." = FIELD("Request No.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                    "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                    IF Status<>Status::Open THEN
                    ERROR('Once document has been released it cannot be edited!');
                    */
            end;
        }
        field(16; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Employees Travelling"."Total Cost" WHERE("Request No." = FIELD("Request No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(17; "Course Title"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                if TrainingNeeds.Get("Course Title") then Description := TrainingNeeds.Description;
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(18; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Planned Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;
            end;
        }
        field(20; "Planned End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;
                "No. Of Days" := ("Planned End Date" - "Planned Start Date") + 1;
            end;
        }
        field(21; "Country Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                if CountryRec.Get("Country Code") then begin
                    Currency := CountryRec.Name;
                end;
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(22; "CBK Website Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 4 : 4;

            trigger OnValidate()
            begin
                "Total Cost (LCY)" := "Exchange Rate" * "Total Cost";
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;
            end;
        }
        field(24; "Total Cost (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(26; Budget; Decimal)
        {
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("Budget Name" = FIELD("Budget Name"), "G/L Account No." = FIELD("GL Account"), "Global Dimension 1 Code" = FIELD("Department Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Actual; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("GL Account"), "Global Dimension 1 Code" = FIELD("Department Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; Commitment; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(29; "GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(30; "Budget Name"; Code[10])
        {
            Caption = 'Fiscal Year';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(31; "Available Funds"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Need Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
        }
        field(33; "Training Objective"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Commisioner No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Commisioner No");
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                if DimVal.Find('-') then "Commissioner Name" := DimVal.Name;
            end;
        }
        field(45; "Commissioner Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Commissioner; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(48; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(49; "Training Need"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Need" where(Status = filter(Application));

            trigger OnValidate()
            var
                Participants: Record "Training Participant";
            begin
                TrainingRequest.SetRange("Employee No", "Employee No");
                TrainingRequest.SetRange("Training Need", "Training Need");
                if TrainingRequest.FindFirst then Error('You have already applied for Training %1 . Kindly choose a new one', "Training Need");
                if TrainingNeeds.Get("Training Need") then begin
                    if TrainingNeeds."Open/Closed" = TrainingNeeds."Open/Closed"::Open then begin
                        TrainingNeeds.CalcFields("Cost Of Training", "Cost Of Training (LCY)");
                        "Planned Start Date" := TrainingNeeds."Start Date";
                        "Planned End Date" := TrainingNeeds."End Date";
                        "No. Of Days" := ("Planned End Date" - "Planned Start Date") + 1;
                        Destination := TrainingNeeds.Location;
                        Description := TrainingNeeds.Description;
                        "Global Dimension 1 Code" := TrainingNeeds."Shortcut Dimension 1 Code";
                        "Global Dimension 2 Code" := TrainingNeeds."Shortcut Dimension 2 Code";
                        "Dimension Set ID" := TrainingNeeds."Dimension Set ID";
                        Venue := TrainingNeeds.Venue;
                        "Country Code" := TrainingNeeds."Country Code";
                        "Cost of Training" := TrainingNeeds."Cost Of Training";
                        "Cost of Training (LCY)" := TrainingNeeds."Cost Of Training (LCY)";
                    end
                    else begin
                        Participants.SetRange("Employee No", "Employee No");
                        if not Participants.FindFirst() then Error('This training can only be applied by shortlisted participants');
                    end;
                end;
                InsertPerDiemCost;
            end;
        }
        field(50; Destination; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Destination."Destination Code";
        }
        field(51; "Cost of Training"; Decimal)
        {
            // CalcFormula = Sum("Training Request Lines".Amount WHERE("Document No." = FIELD("Request No.")));
            //FieldClass = FlowField;
        }
        field(52; "Cost of Training (LCY)"; Decimal)
        {
            // CalcFormula = Sum("Training Request Lines"."Amount (LCY)" WHERE("Document No." = FIELD("Request No.")));
            //FieldClass = FlowField;
        }
        field(53; "Salary Scale"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
        field(54; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(55; Adhoc; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Training Objectives"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Employee Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Request Nos");
            NoSeriesMgt.InitSeries(HRSetup."Training Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            "GL Account" := HRSetup."Account No (Training)";
        end;
        "User ID" := UserId;
        if UserSetup.Get(UserId) then begin
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.Find('-') then "Employee No" := Employee."No.";
            "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            Designation := Employee."Job Title";
            "Salary Scale" := Employee."Salary Scale";
        end;
        "Request Date" := Today;
    end;

    var
        empl: Record Employee;
        TrainingNeeds: Record "Training Need";
        CountryRec: Record "Country/Region";
        CompanyInfo: Record "Company Information";
        PurchSetup: Record "Purchases & Payables Setup";
        DimVal: Record "Dimension Value";
        "--------------Cheruiyot----------------": Integer;
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        HRSetup: Record "Human Resources Setup";
        TravelEmp: Record "Employees Travelling";
        DimMgt: Codeunit DimensionManagement;
        TrainingRequest: Record "Training Request";

    procedure CheckStatus(): Boolean
    begin
        if Status = Status::Released then
            exit(true)
        else
            exit(false);
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        Modify;
    end;

    local procedure InsertPerDiemCost()
    var
        ExpenseCode: Record "Expense Code";
        TrainingRequestLines: Record "Training Request Lines";
        TrainingNeedsLines: Record "Training Needs Lines";
    begin
        ExpenseCode.Reset;
        ExpenseCode.SetRange("Per Diem", true);
        if ExpenseCode.FindFirst then begin
            TrainingNeedsLines.Reset;
            TrainingNeedsLines.SetRange("Document No.", "Training Need");
            TrainingNeedsLines.SetRange("Expense Code", ExpenseCode.Code);
            if TrainingNeedsLines.FindFirst then begin
                TrainingRequestLines.Reset;
                TrainingRequestLines.SetRange("Document No.", "Request No.");
                if TrainingRequestLines.FindFirst then TrainingRequestLines.DeleteAll;
                TrainingRequestLines.Init;
                TrainingRequestLines."Document No." := "Request No.";
                TrainingRequestLines."Employee No" := "Employee No";
                TrainingRequestLines."Expense Code" := ExpenseCode.Code;
                TrainingRequestLines."Training Need No" := "Training Need";
                TrainingRequestLines."G/L Account" := TrainingNeedsLines."G/L Account";
                TrainingRequestLines."Currency Code" := TrainingNeedsLines."Currency Code";
                TrainingRequestLines.Validate(Amount, (GetEmployeePerDiem("Salary Scale", Destination) * "No. Of Days"));
                TrainingRequestLines."Per Diem" := true;
                if TrainingRequestLines.Amount <> 0 then TrainingRequestLines.Insert;
            end;
        end;
    end;

    local procedure GetEmployeePerDiem(JobGroup: Code[20]; Destination: Code[20]): Decimal
    var
        DestinationRate: Record "Destination Rate Entry";
    begin
        DestinationRate.Reset;
        DestinationRate.SetRange("Employee Job Group", JobGroup);
        DestinationRate.SetRange("Destination Code", Destination);
        //DestinationRate.SetRange("Rate Type", DestinationRate."Rate Type"::Training);
        if DestinationRate.FindFirst then exit(DestinationRate."Daily Rate (Amount)");
        exit(0);
    end;
}
