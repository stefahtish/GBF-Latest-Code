page 50472 "Interview Form"
{
    PageType = ListPart;
    SourceTable = "Interview Stage";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    ToolTip = 'Specifies the value of the Applicant No field';
                    ApplicationArea = All;
                }
                field(Panel; Rec.Panel)
                {
                    Caption = 'Panel Member Code';
                    ToolTip = 'Specifies the value of the Panel Member Code field';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                    ApplicationArea = All;
                }
                field("Test Parameter"; Rec."Test Parameter")
                {
                    ToolTip = 'Specifies the value of the Test Parameter field';
                    ApplicationArea = All;
                }
                field("Marks Awarded"; Rec."Marks Awarded")
                {
                    ToolTip = 'Specifies the value of the Marks Awarded field';
                    ApplicationArea = All;
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ToolTip = 'Specifies the value of the Pass Mark field';
                    ApplicationArea = All;
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    ToolTip = 'Specifies the value of the Maximum Marks field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
