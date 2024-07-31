tableextension 50142 RelativeExt extends Relative
{
    fields
    {
        field(50000; "Medical Scheme No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "National ID/Passport No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " Male", Female;
        }
        field(50006; "In-Patient Entitlement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Out-Patient Entitlment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Amount Spend (In-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Amout Spend (Out-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Policy Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Medical Cover Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "In House", Outsourced;
        }
        field(50012; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}
