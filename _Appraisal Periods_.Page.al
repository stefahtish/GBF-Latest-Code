page 50446 "Appraisal Periods"
{
    PageType = List;
    SourceTable = "Appraisal Periods";
    ApplicationArea = All;

    //PromotedActionCategories = 'New,Process,Reports,Close';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    Visible = false;
                }
                field(Active; Rec.Active)
                {
                }
                field(Closed; Rec.Closed)
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Close)
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Closed := true;
                    Rec.Active := false;
                    Rec.Modify();
                end;
            }
        }
    }
}
