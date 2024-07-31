page 51186 "Compliance Reg. Subform"
{
    Caption = 'Compliance Subform';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Description of Legislation"; Rec."Description of Legislation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description of Legislation field';
                }
                field("Relevant Legislation"; Rec."Relevant Legislation")
                {
                    Caption = 'Relevant Legislation';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Relevant Legislation field';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Comments on Non Compliance';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comments on Non Compliance field';
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Action to Rectify Non-Compliance';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Action to Rectify Non-Compliance field';
                }
                field("Responsible Personnel Code"; Rec."Responsible Personnel Code")
                {
                    Caption = 'Personel Responsible';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Personel Responsible field';
                }
                field("Responsible Personnel"; Rec."Responsible Personnel")
                {
                    Caption = 'Name of Personel Responsible';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name of Personel Responsible field';
                }
                field("Update Date"; Rec."Update Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Date field';
                }
                field("Update Frequency"; Rec."Update Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Frequency field';
                }
                field("Update Stopped"; Rec."Update Stopped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Stopped field';
                }
                //Last Update
                //Next Update
                //Update Frequency
            }
        }
    }
    actions
    {
    }
}
