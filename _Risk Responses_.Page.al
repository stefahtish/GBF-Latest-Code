page 51196 "Risk Responses"
{
    PageType = ListPart;
    SourceTable = "Risk Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Options';
                    Visible = false;
                }
                field("Mitigation Actions"; Rec."Mitigation Actions")
                {
                }
                field("Mitigation Owner"; Rec."Mitigation Owner")
                {
                }
                field(Timelines; Rec.Timelines)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
