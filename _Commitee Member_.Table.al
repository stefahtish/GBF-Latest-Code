table 50138 "Commitee Member"
{
    fields
    {
        field(1; "Ref No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; Commitee; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Procurement Committees";
        }
        field(3; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No")then begin
                    Empl.TestField("User ID");
                    Name:=Empl."First Name" + ' ' + Empl."Last Name";
                end;
            end;
        }
        field(4; Name; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Appointment No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            // if Appoitment.Get("Appointment No") then begin
            //     "Appointment No" := Appoitment."Appointment No";
            //     Commitee := Appoitment."Committee ID";
            // end;
            end;
        }
        field(6; Chair; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Secretary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Tender No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Role; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Member, Chair, Secretary;
        }
        field(10; "Committee Type"; Option)
        {
            OptionMembers = Opening, Evaluation, Negotiation, Inspection, Specialized, External;
            FieldClass = FlowField;
            CalcFormula = lookup("Tender Committees"."Committee Type" where("Appointment No"=field("Appointment No")));
        }
        field(11; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; External; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appointment No", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Empl: Record Employee;
// Appoitment: Record "Tender Committees";
}
