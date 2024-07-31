page 50951 "Licenses"
{
    Caption = 'Regulatory Permits';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "License and Permit Category";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("License/Permit Category"; Rec."License/Permit Category")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("License Code"; Rec."License Code")
                {
                    ApplicationArea = All;
                }
                field("Annual fees(Ksh)"; Rec."Annual fees(Ksh)")
                {
                    ApplicationArea = All;
                }
                field("Application fees(Ksh)"; Rec."Application fees(Ksh)")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
                field("Receivables G/L Account"; Rec."Receivables G/L Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."License/Permit" := Rec."License/Permit"::License;
    end;
}
