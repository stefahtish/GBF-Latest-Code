table 50397 "Other Deductions"
{
    DrillDownPageID = "Other Earnings";
    LookupPageID = "Other Earnings";

    fields
    {
        field(1; "Main Deduction"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX.Code;
        }
        field(2; "Earning Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = EarningsX.Code;

            trigger OnValidate()
            begin
                if DeductionsX.Get("Main Deduction")then begin
                    if DeductionsX."Calculation Method" <> DeductionsX."Calculation Method"::"% of Other Earnings" then Error('Calculation method must be "% of Other Earnings" for %1 - %2', DeductionsX.Code, DeductionsX.Description);
                end;
                EarningsX.Get("Earning Code");
                Description:=EarningsX.Description;
            end;
        }
        field(3; Description; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Main Deduction", "Earning Code", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var EarningsX: Record EarningsX;
    DeductionsX: Record DeductionsX;
}
