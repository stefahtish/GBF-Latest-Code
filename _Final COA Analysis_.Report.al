report 50396 "Final COA Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FinalCOA.rdl';
    WordLayout = './FinalCOA.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(AnalysisLines; "Sample Test Lines")
        {
            column(SampleID; "Sample ID")
            {
            }
            column(SampleName; SentenceFormat("Sample Name"))
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
                column(Resultauthorizationdate; "Result authorization date")
                {
                }
                column(Resultverificationdate; "Result verification date")
                {
                }
                column(Resultsdate; "Results date")
                {
                }
                column(Sampletemperature; "Sample temperature")
                {
                }
                column(Submitresults; "Submit results")
                {
                }
                column(Testingdate; "Testing date")
                {
                }
                column(TestingofficerNo; "Testing officer No.")
                {
                }
                column(Testingofficer; "Testing officer")
                {
                }
                column(Testing_date; "Testing date")
                {
                }
                column(Remarks; Remarks)
                {
                }
                column(Results; Results)
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
            }
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
}
