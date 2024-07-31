page 50942 "Enforcement List"
{
    Caption = 'Enforcement List';
    PageType = List;
    CardPageId = "Enforcement Card";
    Editable = false;
    SourceTable = "Enforcement Header";
    SourceTableView = SORTING("No.") ORDER(Descending);
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
                field("Confiscation Owner"; Rec."Confiscation Owner")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;
                }
                field("Action To Be Taken"; Rec."Action To Be Taken")
                {
                    ApplicationArea = All;
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
}
