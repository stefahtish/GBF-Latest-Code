table 50347 "Imprest Line Activities"
{
    Caption = 'Imprest Line Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Imprest No"; Code[20])
        {
            Caption = 'Imprest No';
            DataClassification = ToBeClassified;
        }
        field(2; "Imprest Line No"; Integer)
        {
            Caption = 'Imprest Line No';
            DataClassification = ToBeClassified;
        }
        field(3; Activity; Code[20])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.get("Employee No.")then Description:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "No of Days"; Integer)
        {
            Caption = 'No of Days';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                TestField(Destination);
                Modify();
                //if Destination <> ' ' then
                "Per Diem":=GetDestinationRate();
                Validate("Per Diem");
            end;
        }
        field(8; "Destination"; Code[20])
        {
            Caption = 'Area';
            DataClassification = ToBeClassified;
            TableRelation = Destination;
        }
        field(9; "Per Diem"; Decimal)
        {
            Caption = 'Per Diem';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(10; Transport; Decimal)
        {
            Caption = 'Transport';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(11; "Transport Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Personal Vehicle", Transport, "Board Vehicle";
            OptionCaption = ' ,Personal Vehicle,Transport,Board Vehicle';
        }
        field(12; "Estimated Mileage Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(13; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No of Days" <> 0 then Validate("No of Days");
                if "End Date" <> 0D then if "End Date" < "Start Date" then Error('End date must be greater than start date');
            end;
        }
        field(14; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Start Date" <> 0D then if "End Date" < "Start Date" then Error('End date must be greater than start date');
                if("End Date" <> 0D) and ("Start Date" <> 0D)then "No of Days":=("End Date" - "Start Date");
            end;
        }
        field(15; "Activity No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Items, Participants;
            DataClassification = ToBeClassified;
        }
        field(17; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.")then Description:=Item.Description;
            end;
        }
        field(18; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Imprest No", "Imprest Line No", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure UpdateTotals()
    var
        myInt: Integer;
    begin
        Amount:=Transport + "Per Diem" + "Estimated Mileage Amount";
    end;
    trigger OnInsert()
    var
        myInt: Integer;
        Activities: Record "Imprest Line Activities";
    begin
        Activities.Reset();
        Activities.SetRange("Imprest No", "Imprest No");
        Activities.SetRange("Imprest Line No", "Imprest Line No");
        if Activities.FindLast()then "Line No.":=Activities."Line No." + 1
        else
            "Line No.":=1;
    end;
    local procedure GetDestinationRate(): Decimal var
        DailyRate: Decimal;
        TotalAmount: Decimal;
        DestinationSetup: Record Destination;
        DestinationRate: Record "Destination Rate Entry";
    begin
        DestinationSetup.Reset;
        DestinationSetup.SetRange("Destination Code", Destination);
        if DestinationSetup.FindFirst then begin
            DestinationRate.Reset;
            DestinationRate.SetRange("Destination Code", Destination);
            DestinationRate.SetRange("Employee Job Group", GetJobGroup);
            DestinationRate.SetRange("Payment Type", DestinationRate."Payment Type"::Imprest);
            if DestinationRate.FindFirst then begin
                DailyRate:=DestinationRate."Daily Rate (Amount)";
                TotalAmount:=DailyRate * "No of Days";
                exit(TotalAmount);
            //PLines.MODIFY;
            end
            else
                Error('The job group rates for destination %1 have not been set up.', Destination);
        end
        else
            Error('The destination %1 is not set up.', Destination);
    end;
    local procedure GetJobGroup(): Code[50]var
        Employee: Record Employee;
    begin
        Employee.Reset;
        Employee.SetRange("No.", "Employee No.");
        if Employee.FindFirst then exit(Employee."Salary Scale");
    end;
}
