page 51218 "Risk KRI"
{
    Caption = 'Incident priority';
    PageType = List;
    SourceTable = "Risk KRI";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
