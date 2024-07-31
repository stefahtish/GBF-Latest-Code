page 51224 "Incident Priority Setup"
{
    Caption = 'Incident Priority Setup';
    PageType = List;
    SourceTable = "Incident Priority Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Mitigation Plan"; Rec."Mitigation Plan")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
