table 50396 "Other Earnings"
{
    DrillDownPageID = "Other Earnings";
    LookupPageID = "Other Earnings";

    fields
    {
        field(1; "Main Earning"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = EarningsX.Code;
        }
        field(2; "Earning Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = EarningsX.Code;

            trigger OnValidate()
            begin
                if "Earning Code" = "Main Earning" then Error('Can not be same');
                if EarningsX.Get("Main Earning")then begin
                    if EarningsX."Calculation Method" <> EarningsX."Calculation Method"::"% of Other Earnings" then Error('Calculation method must be "% of Other Earnings" for %1 - %2', EarningsX.Code, EarningsX.Description)end;
                EarningsX.Reset;
                if EarningsX.Get("Earning Code")then Description:=EarningsX.Description;
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
        key(Key1; "Main Earning", "Earning Code", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var EarningsX: Record EarningsX;
}
