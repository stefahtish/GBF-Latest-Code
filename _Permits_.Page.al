page 50950 "Permits"
{
    Caption = 'Permit categories';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "License and Permit Category";
    SourceTableView = where("License/Permit" = const(Permit));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("License/Permit Category"; Rec."License/Permit Category")
                {
                    Caption = 'Permit category';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
                    Visible = false;
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
        Rec."License/Permit" := Rec."License/Permit"::Permit;
    end;
}
