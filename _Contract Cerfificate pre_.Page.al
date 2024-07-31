page 50992 "Contract Cerfificate pre"
{
    PageType = Card;
    SourceTable = Contract1;
    Caption = 'Contract Certificate';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Contract Name"; Rec."Contract Name")
                {
                    Enabled = false;
                }
                field(Client; Rec.Client)
                {
                    Visible = false;
                }
                field("Contract Value"; Rec."Contract Value")
                {
                    Editable = false;
                }
                field("Provisional Sum"; Rec."Provisional Sum")
                {
                }
                field("Consultancy Fee"; Rec."Consultancy Fee")
                {
                    Enabled = false;
                }
                field("Date of commencement"; Rec."Date of commencement")
                {
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    Enabled = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Enabled = false;
                }
                field("Date of Certificate"; Rec."Date of Certificate")
                {
                }
                field("Title Of Assignment"; Rec."Title Of Assignment")
                {
                }
                field("IPC No."; Rec."IPC No.")
                {
                }
            }
            part(Control4; "Contract Amount")
            {
                SubPageLink = "Conract No." = FIELD("Contract No.");
                Visible = false;
            }
            part(Control3; "Schedule List")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."), "Schedule No." = FIELD("IPC No.");
            }
            part(Contract_Delivarable; Cont_Delivarable)
            {
                Caption = 'Contract_Deliverable';
                SubPageLink = "Conract No." = FIELD("Contract No.");
                Visible = false;
            }
            part("Contract_Approximation of  Provisional Sum"; "Cont_Approxi Pro Sum")
            {
                Caption = 'Contract_Approximation of  Provisional Sum';
                SubPageLink = "Conract No." = FIELD("Contract No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Generate Certificate")
            {
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TESTFIELD(51519947)
                    Contract.SetRange("Contract No.", Rec."Contract No.");
                    if Contract.Find('-') then REPORT.Run(Report::"Consultant Certificate", true, true, Contract);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        // "Provisional Sum":="Original Contract Price"-"Contract Value";
        // Rec.MODIFY;
    end;

    var
        Contract: Record Contract1;
}
