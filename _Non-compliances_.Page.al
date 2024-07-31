page 51034 "Non-compliances"
{
    Caption = 'Overdue Non-compliances';
    PageType = List;
    SourceTable = "Enforcement NonCompliance";
    SourceTableView = where(Overdue = const(true), Complied = const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Action To be Taken"; Rec."Action To be Taken")
                {
                    ApplicationArea = All;
                }
                field("Compliance Dateline"; Rec."Compliance Dateline")
                {
                    ApplicationArea = All;
                }
                field("Compliance Officer No"; Rec."Compliance Officer No")
                {
                }
                field("Compliance Officer Name"; Rec."Compliance Officer Name")
                {
                }
            }
        }
    }
}
