table 50369 "Pensioners Payroll Periods"
{
    fields
    {
        field(1; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                Name:=Format("Starting Date", 0, '<Month Text>');
            end;
        }
        field(2; Name; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //TESTFIELD("Date Locked",FALSE);
            end;
        }
        field(4; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(5; "Date Locked"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50000; "Pay Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Close Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
            //TESTFIELD("Close Pay",FALSE);
            end;
        }
        field(50002; "P.A.Y.E"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50003; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open, "Pending Approval", Approved;
        }
        field(50004; "Total Earnings"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50005; "Total Deductions"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50007; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Suspended,Active';
            OptionMembers = Suspended, Active;
        }
        field(50008; "Pay Mode Filter"; Code[20])
        {
            FieldClass = Normal;
        }
        field(50009; "Prepared By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50010; "Prepared Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Starting Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var AccountingPeriod2: Record "Pensioners Payroll Periods";
}
