page 50641 "Salary Scale"
{
    PageType = List;
    SourceTable = "Salary Scale";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Scale; Rec.Scale)
                {
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                }
                field("Minimum Pointer"; Rec."Minimum Pointer")
                {
                }
                field("Maximum Pointer"; Rec."Maximum Pointer")
                {
                }
                field("Max Imprest"; Rec."Max Imprest")
                {
                    Caption = 'Max Imprest Unsurrendered';
                }
                field("Leave Days"; Rec."Leave Days")
                {
                }
                field("In Patient Limit"; Rec."In Patient Limit")
                {
                    Visible = false;
                }
                field("Out Patient Limit"; Rec."Out Patient Limit")
                {
                    Visible = false;
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                }
                field("Leave Entitlement"; Rec."Leave Entitlement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Entitlement field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Pointers)
            {
                action(Pointer)
                {
                    Caption = 'Pointer';
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Salary pointer";
                    RunPageLink = "Salary Scale"=FIELD(Scale);
                }
            }
        }
    }
}
