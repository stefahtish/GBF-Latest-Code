report 50395 "COA Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './COA.rdl';
    WordLayout = './COA.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(AnalysisLines; "Sample Test Lines")
        {
            column(Sample_ID; "Sample ID")
            {
            }
            column(Sample_Name2; SentenceFormat("Sample Name"))
            {
            }
            column(Code_Lines; SentenceFormat(Test))
            {
            }
            column(Specification_Lines; SentenceFormat(Specification))
            {
            }
            column(Remarks_Lines; SentenceFormat(Remarks))
            {
            }
            column(Results_Lines; SentenceFormat(Results))
            {
            }
            column(Testingdate; "Submission DateTime")
            {
            }
            column(TestingSignature; UserSetup.Signature)
            {
            }
            // column(ReferenceStandardMethod_AnalysisLines; "Reference Standard Method")
            // {
            // }
            dataitem(SampleAnalysisAndReporting; "Sample Analysis And Reporting")
            {
                DataItemLink = "Analysis No." = field("Entry No.");

                column(AnalysisNo; "Analysis No.")
                {
                }
                column(Authorizationofficer; "Authorization officer")
                {
                }
                column(COANo; "COA No.")
                {
                }
                column(Dateofsampledisposal; "Date of sample disposal")
                {
                }
                column(Dateresultssubmitted; "Date results submitted")
                {
                }
                column(Labsectionreceived; "Lab section received")
                {
                }
                column(NoSeries; "No. Series")
                {
                }
                column(Resultauthorizationdate; "Approval datetime")
                {
                }
                column(Resultverificationdate; "Result verification date")
                {
                }
                column(Resultsdate; "Results date")
                {
                }
                column(SampleID; "Sample ID")
                {
                }
                column(SampleName; "Sample Name")
                {
                }
                column(Sampletemperature; "Sample temperature")
                {
                }
                column(Submitresults; "Submit results")
                {
                }
                column(TestingofficerNo; "Testing officer No.")
                {
                }
                column(Testingofficer; "Testing officer")
                {
                }
                column(Remarks; Remarks)
                {
                }
                column(Results; Results)
                {
                }
                column(COA_No_; "COA No.")
                {
                }
                column(Expiry_Date; "Expiry Date")
                {
                }
                column(Manufacture_Date; "Manufacture Date")
                {
                }
                column(Client_Name; SentenceFormat("Client Name"))
                {
                }
                column(KDB_License_number; "KDB License number")
                {
                }
                column(Batch_No_; "Batch No.")
                {
                }
                column(AuthorizingSignature; UserSetup1.Signature)
                {
                }
                column(ApprovalEntry_ApproverId; GetUserName(Approver[2]))
                {
                }
                dataitem("Sample Reception Header"; "Sample Reception Header")
                {
                    DataItemLink = "Entry No." = field("Sample Reception No");

                    column(County; SentenceFormat("County Name"))
                    {
                    }
                    column(Location; SentenceFormat(Location))
                    {
                    }
                    column(ReceptionDate; Date)
                    {
                    }
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    UserSetup1.Reset();
                    UserSetup1.setrange("Employee No.", "Authorized By");
                    if UserSetup1.FindFirst() then UserSetup1.CalcFields(Signature);
                    ApprovalEntries.Reset();
                    ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                    ApprovalEntries.SetRange("Document No.", "Analysis No.");
                    if ApprovalEntries.Find('-') then begin
                        repeat
                            if ApprovalEntries."Sequence No." = 1 then begin
                                Approver[1] := ApprovalEntries."Sender ID";
                                ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                                if UserSetup.Get(Approver[1]) then UserSetup.CalcFields(Signature);
                                Approver[2] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                                if UserSetup1.Get(Approver[2]) then UserSetup1.CalcFields(Signature);
                            end;
                            if ApprovalEntries."Sequence No." = 2 then begin
                                Approver[3] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                                if UserSetup2.Get(Approver[3]) then UserSetup2.CalcFields(Signature);
                            end;
                            if ApprovalEntries."Sequence No." = 3 then begin
                                Approver[4] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                                if UserSetup3.Get(Approver[4]) then UserSetup3.CalcFields(Signature);
                            end;
                        until ApprovalEntries.Next = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                UserSetup.Reset();
                UserSetup.setrange("Employee No.", "Done By");
                if UserSetup.FindFirst() then UserSetup.CalcFields(Signature);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    procedure SentenceFormat(Name: Text[1000]): Text[1000]
    var
        I: Integer;
    begin
        For I := 1 to Strlen(name) do begin
            if I = 1 then
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])))
            else IF Name[I - 1] = 32 THEN
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])))
            ELSE
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])));
        end;
        EXIT(Name);
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;

    trigger OnPreReport()
    begin
        TargetDairyProduce.Reset();
        TargetDairyProduce.SetRange(Product, "Sample Reception Header"."Sample Name");
    end;

    var
        TargetDairyProduce: Record "Laboratory Products";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
}
