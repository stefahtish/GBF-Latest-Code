table 50200 "Activity Work Programme Lines"
{
    Caption = 'Activity Workplan Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Items, Participants, Facilitators;
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
        field(6; "Item No."; Code[20])
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
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "No of Days"; Integer)
        {
            Caption = 'No of Days';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                TestField(Destination);
                Modify();
                if Type <> Type::Facilitators then begin
                    "Per Diem":=GetDestinationRate();
                    Validate("Per Diem");
                end;
            end;
        }
        field(9; "Destination"; Code[20])
        {
            Caption = 'Area';
            DataClassification = ToBeClassified;
            TableRelation = Destination;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("No of Days");
            end;
        }
        field(10; "Per Diem"; Decimal)
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
        field(11; Transport; Decimal)
        {
            Caption = 'Transport';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                if Type = Type::Participants then UpdateTotals();
                if Type = Type::Facilitators then UpdateAmount();
            end;
        }
        field(12; "Procurement Method"; Code[20])
        {
            Caption = 'Procurement Method';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Method";
        }
        field(13; "Transport Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Personal Vehicle", Transport, "Board Vehicle";
            OptionCaption = ' ,Personal Vehicle,Transport,Board Vehicle';
        }
        field(14; "Estimated Mileage Amount"; Decimal)
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
        field(15; "Amount used"; Decimal)
        {
        // FieldClass = FlowField;
        // CalcFormula = impres
        }
        field(163; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Imprest, "Procurement Process";
        }
        field(164; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount:="Unit Cost" * Quantity;
            end;
        }
        field(165; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount:="Unit Cost" * Quantity;
            end;
        }
        field(166; "No of Facilitator"; Integer)
        {
            Caption = 'No of Facilitator';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(167; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rates';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(168; "Procurement Plan Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
        }
        field(169; "Remaining Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Mileage claimed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Type, "Line No.")
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
    local procedure UpdateAmount()
    begin
        if("No of days" <> 0) and ("Daily Rate" <> 0) and ("No of Facilitator" <> 0)then Amount:=("No of days" * "Daily Rate" * "No of Facilitator") + "Transport";
    end;
}
