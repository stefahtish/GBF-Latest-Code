page 50880 "New Mail"
{
    PageType = Card;
    SourceTable = "Dispatched Letter Register";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Ref/S.No';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field(Type; Rec.Type)
                {
                    OptionCaption = 'Incoming,Outgoing,Dispatch';
                }
                field(From; Rec.From)
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Action Officer 1 No."; Rec."Action Officer 1 No.")
                {
                    Caption = 'Action Officer 1 No.';
                }
                field("Action Officer1 Name"; Rec."Action Officer1 Name")
                {
                    Caption = 'Action Officer1 Name';
                }
                field("Action Officer 1 email"; Rec."Action Officer 1 Email")
                {
                }
                field("Action Officer 2 No."; Rec."Action Officer 2 No.")
                {
                    Caption = 'Action Officer 2 No.';
                }
                field("Action Officer 2 email"; Rec."Action Officer 2 Email")
                {
                }
                field("Action Officer2 Name"; Rec."Action Officer2 Name")
                {
                    Caption = 'Action Officer 2 Name';
                }
                field("Action Officer 3 No."; Rec."Action Officer 3 No.")
                {
                    Caption = 'Action Officer 3 No.';
                }
                field("Action Officer3 Name"; Rec."Action Officer3 Name")
                {
                    Caption = 'Action Officer 3 Name';
                }
                field("Action Officer 3 email"; Rec."Action Officer 3 Email")
                {
                }
                field("Action Officer 4 No"; Rec."Action Officer 4 No")
                {
                    Caption = 'Action Officer 4 No.';
                }
                field("Action Officer 4 email"; Rec."Action officer 4 Email")
                {
                }
                field("Action Officer 4 Name"; Rec."Action Officer 4 Name")
                {
                    Caption = 'Action Officer 4 Name';
                }
                field("External Dispatch Type"; Rec."External Dispatch type")
                {
                    Caption = 'External Dispatch Type';
                }
                field("Internal Dispatch Type"; Rec."Internal Dispatch type")
                {
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                }
                field("Remarks/ FILE No."; Rec."Remarks/ FILE No.")
                {
                }
                field(Dispatched; Rec.Dispartched)
                {
                }
                field("Received by Action Officer"; Rec."Received by Action Officer")
                {
                }
                field("Action Officer Remarks"; Rec."Action Officer Remarks")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send to Registry")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RSetup.Get;
                    RSetup.TestField("Registry Email");
                    //TESTFIELD("Remarks/ FILE No.");
                    Rec.Sender := UserId;
                    if UserSetup.Get(Rec.Sender) then SenderAddress := UserSetup."E-Mail";
                    Recepient.Add(RSetup."Registry Email");
                    Body := StrSubstNo('Please confirm the reception of the Letter No %1 ', Rec."No.");
                    SMTP.Create(Recepient, 'LETTERS', Body, true);
                    Email.Send(SMTP);
                    Rec.Send := true;
                    Rec.Modify;
                end;
            }
            action(Receive)
            {
                trigger OnAction()
                begin
                    RSetup.Get;
                    RSetup.TestField(RSetup."Resource Admin");
                    if UserSetup.Get(Rec.Sender) then SenderAddress := UserSetup."E-Mail";
                    if UserSetup.Get(RSetup."Resource Admin") then Recepient.add(UserSetup."E-Mail");
                    Body := StrSubstNo('I acknowledge the reception of the Letter No % 1 ', Rec."No.");
                    SMTP.Create(Recepient, 'LETTERS', Body, true);
                    Email.Send(SMTP);
                    Rec.Received := true;
                    Rec.Receiver := UserId;
                    Rec.Modify;
                end;
            }
            action(Notify)
            {
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Notifications();
                end;
            }
        }
    }
    var
        RSetup: Record "Resource Centre Setup";
        Recepient: list of [Text];
        Body: Text[250];
        SenderAddress: Text[250];
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        SMTP: Codeunit "Email Message";
        Email: Codeunit email;
}
