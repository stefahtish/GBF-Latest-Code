page 50551 "Appraisee's Appraisal Comments"
{
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                }
                field("Performance Related Dicussions"; Rec."Performance Related Dicussions")
                {
                    Visible = false;
                }
                field("Extent of Discussion Help"; Rec."Extent of Discussion Help")
                {
                    Visible = false;
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    Caption = 'Appraisee';
                }
                field("Comments On Supervisor"; Rec."Comments On Supervisor")
                {
                    Caption = 'Appraiser';
                }
                field(Date; Rec.Date)
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
